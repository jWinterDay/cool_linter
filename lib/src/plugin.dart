// @dart=2.12

import 'dart:async';

// ignore_for_file: implementation_imports
// fignore_for_file: avoid_as
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/context/builder.dart';
import 'package:analyzer/src/context/context_root.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:cool_linter/src/checker.dart';
// import 'package:analyzer/src/workspace/workspace.dart';
// import 'package:analyzer_plugin/plugin/plugin.dart';
// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:analyzer_plugin/protocol/protocol.dart';
// import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
// import 'package:analyzer_plugin/protocol/protocol.dart';
// import 'package:analyzer/src/dart/analysis/file_state.dart';
// import 'package:cool_linter/src/checker.dart';

class CoolLinterPlugin extends ServerPlugin {
  CoolLinterPlugin(
    ResourceProvider provider,
  ) : super(provider);

  final Checker _checker = Checker();

  @override
  List<String> get fileGlobsToAnalyze => const <String>['*.dart'];

  @override
  String get name => 'Cool linter';

  @override
  String get version => '1.0.0-alpha.0';

  @override
  String get contactInfo => 'https://github.com/jWinterDay/cool_linter';

  /// see: https://github.com/simolus3/moor/blob/master/moor_generator/lib/src/backends/common/base_plugin.dart
  // AnalysisDriverScheduler get dartScheduler {
  //   if (_dartScheduler == null) {
  //     _dartScheduler = AnalysisDriverScheduler(performanceLog);
  //     _dartScheduler.start();
  //   }

  //   return _dartScheduler;
  // }

  // AnalysisDriverScheduler _dartScheduler;

  @override
  AnalysisDriverGeneric createAnalysisDriver(plugin.ContextRoot contextRoot) {
    final ContextRoot root = ContextRoot(
      contextRoot.root,
      contextRoot.exclude,
      pathContext: resourceProvider.pathContext,
    )..optionsFilePath = contextRoot.optionsFile;

    final ContextBuilder contextBuilder = ContextBuilder(resourceProvider, sdkManager, null)
      ..analysisDriverScheduler = analysisDriverScheduler
      ..byteStore = byteStore
      ..performanceLog = performanceLog
      ..fileContentOverlay = fileContentOverlay;

    // final ContextRoot root = ContextRoot(
    //   contextRoot.root,
    //   contextRoot.exclude,
    //   pathContext: resourceProvider.pathContext,
    // )..optionsFilePath = contextRoot.optionsFile;

    // final ContextBuilder contextBuilder = ContextBuilder(
    //   resourceProvider,
    //   sdkManager,
    //   null,
    // )
    //   ..analysisDriverScheduler = analysisDriverScheduler //dartScheduler // analysisDriverScheduler
    //   ..byteStore = byteStore
    //   ..performanceLog = performanceLog
    //   ..fileContentOverlay = FileContentOverlay();
    // // ..fileContentOverlay = fileContentOverlay;
    // //

    // final Workspace workspace = ContextBuilder.createWorkspace(
    //   resourceProvider,
    //   options: ContextBuilderOptions(), //contextBuilder.builderOptions,
    //   rootPath: contextRoot.root,
    //   // lookForBazelBuildFileSubstitutes: false,
    // );

    // // return builder.createSourceFactory(folder.path, workspace);

    final AnalysisDriver analysisDriver = contextBuilder.buildDriver(root); //, workspace);

    runZonedGuarded(
      () {
        analysisDriver.results.listen((ResolvedUnitResult analysisResult) {
          _processResult(analysisDriver, analysisResult);
        });
      },
      (Object e, StackTrace stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'Unexpected error: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
      },
    );

    return analysisDriver;
  }

  void _processResult(AnalysisDriver analysisDriver, ResolvedUnitResult analysisResult) {
    final String filePath = analysisResult.path;

    // channel.sendNotification(
    //   plugin.AnalysisErrorsParams(
    //     analysisResult.path,
    //     <AnalysisError>[
    //       AnalysisError(
    //         AnalysisErrorSeverity.WARNING,
    //         AnalysisErrorType.LINT,
    //         Location(
    //           analysisResult.path, //parseResult.unit?.declaredElement?.source.fullName ?? 'todo filename',
    //           1, // offset
    //           1, // length
    //           1, //lineIndex, // startLine
    //           1, // startColumn
    //           // 1, // endLine
    //           // 1, // endColumn
    //         ),
    //         'message 888',
    //         'code_888',
    //       ),
    //     ],
    //     // checkResult.keys.toList(),
    //   ).toNotification(),
    // );

    try {
      // If there is no relevant analysis result, notify the analyzer of no errors.
      if (analysisResult.unit == null) {
        channel.sendNotification(
          plugin.AnalysisErrorsParams(
            filePath,
            <AnalysisError>[],
          ).toNotification(),
        );
      } else {
        // If there is something to analyze, do so and notify the analyzer.
        // Note that notifying with an empty set of errors is important as
        // this clears errors if they were fixed.
        final Map<AnalysisError, plugin.PrioritizedSourceChange> checkResult = _checker.checkResult(
          pattern: RegExp('^Test{1}'),
          parseResult: analysisResult,
        );

        channel.sendNotification(
          plugin.AnalysisErrorsParams(
            filePath,
            checkResult.keys.toList(),
          ).toNotification(),
        );
      }
    } catch (exc, stackTrace) {
      // Notify the analyzer that an exception happened.
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          exc.toString(),
          stackTrace.toString(),
        ).toNotification(),
      );
    }
  }

  @override
  void contentChanged(String path) {
    super.driverForPath(path)?.addFile(path);
  }

  // @override
  // Future<plugin.EditGetFixesResult> handleEditGetFixes(plugin.EditGetFixesParams parameters) async {
  //   try {
  //     final AnalysisDriver analysisDriver = driverForPath(parameters.file) as AnalysisDriver;
  //     final ResolvedUnitResult analysisResult = await analysisDriver.getResult(parameters.file);

  //     // Get errors and fixes for the file.
  //     final Map<AnalysisError, plugin.PrioritizedSourceChange> checkResult = _checker.checkResult(
  //       pattern: RegExp('^Test{1}'),
  //       parseResult: analysisResult,
  //     );

  //     // Return any fixes that are for the expected file.
  //     final List<plugin.AnalysisErrorFixes> fixes = <plugin.AnalysisErrorFixes>[];

  //     for (final AnalysisError error in checkResult.keys) {
  //       final plugin.PrioritizedSourceChange checkResultByError = checkResult[error]!;

  //       if (error.location.file == parameters.file && checkResultByError.change.edits.single.edits.isNotEmpty) {
  //         fixes.add(plugin.AnalysisErrorFixes(
  //           error,
  //           fixes: <plugin.PrioritizedSourceChange>[checkResultByError],
  //         ));
  //       }
  //     }

  //     return plugin.EditGetFixesResult(fixes);
  //   } catch (exc, stackTrace) {
  //     channel.sendNotification(
  //       plugin.PluginErrorParams(
  //         false,
  //         exc.toString(),
  //         stackTrace.toString(),
  //       ).toNotification(),
  //     );

  //     return plugin.EditGetFixesResult(<plugin.AnalysisErrorFixes>[]);
  //   }
  // }
}

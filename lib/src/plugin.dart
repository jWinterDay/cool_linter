import 'dart:async';

// ignore_for_file: implementation_imports
// fignore_for_file: avoid_as
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';

import 'package:analyzer/src/context/builder.dart';
import 'package:analyzer/src/workspace/workspace.dart';
import 'package:analyzer/src/context/context_root.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
// import 'package:analyzer_plugin/plugin/plugin.dart';
// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:analyzer_plugin/protocol/protocol.dart';
// import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import 'package:analyzer_plugin_fork/plugin/plugin.dart';
import 'package:analyzer_plugin_fork/protocol/protocol_common.dart';
import 'package:analyzer_plugin_fork/protocol/protocol.dart';
import 'package:analyzer_plugin_fork/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer/src/dart/analysis/file_state.dart';

import 'package:cool_linter/src/checker.dart';

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
  AnalysisDriverScheduler get dartScheduler {
    if (_dartScheduler == null) {
      _dartScheduler = AnalysisDriverScheduler(performanceLog);
      _dartScheduler!.start();
    }

    return _dartScheduler!;
  }

  AnalysisDriverScheduler? _dartScheduler;

  @override
  AnalysisDriverGeneric createAnalysisDriver(plugin.ContextRoot contextRoot) {
    final ContextRoot root = ContextRoot(
      contextRoot.root,
      contextRoot.exclude,
      pathContext: resourceProvider.pathContext,
    )..optionsFilePath = contextRoot.optionsFile;

    final ContextBuilder contextBuilder = ContextBuilder(
      resourceProvider,
      sdkManager,
      null,
    )
      ..analysisDriverScheduler = analysisDriverScheduler //dartScheduler // analysisDriverScheduler
      ..byteStore = byteStore
      ..performanceLog = performanceLog
      ..fileContentOverlay = FileContentOverlay();
    // ..fileContentOverlay = fileContentOverlay;
    //

    final Workspace workspace = ContextBuilder.createWorkspace(
      resourceProvider: resourceProvider,
      options: ContextBuilderOptions(), //contextBuilder.builderOptions,
      rootPath: contextRoot.root,
      // lookForBazelBuildFileSubstitutes: false,
    );

    // return builder.createSourceFactory(folder.path, workspace);

    final AnalysisDriver analysisDriver = contextBuilder.buildDriver(root, workspace);

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
            e.toString(),
            stackTrace.toString(),
          ).toNotification(),
        );
      },
    );

    // analysisDriver.results.listen((ResolvedUnitResult analysisResult) {
    //   _processResult(analysisDriver, analysisResult);
    // });

    return analysisDriver;
  }

  @override
  Future<plugin.AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(
    plugin.AnalysisSetContextRootsParams parameters,
  ) async {
    final plugin.AnalysisSetContextRootsResult result = await super.handleAnalysisSetContextRoots(parameters);
    // The super-call adds files to the driver, so we need to prioritize them so they get analyzed.
    // _updatePriorityFiles();

    return result;
  }

  @override
  Future<plugin.AnalysisSetPriorityFilesResult> handleAnalysisSetPriorityFiles(
    plugin.AnalysisSetPriorityFilesParams parameters,
  ) async {
    // _filesFromSetPriorityFilesRequest = parameters.files;
    // _updatePriorityFiles();

    return plugin.AnalysisSetPriorityFilesResult();
  }

  // @override
  // Future<plugin.EditGetFixesResult> handleEditGetFixes(
  //   plugin.EditGetFixesParams parameters,
  // ) async {
  // try {
  //   final driver = driverForPath(parameters.file) as AnalysisDriver;
  //   final analysisResult = await driver.getResult(parameters.file);

  //   final fixes = _check(driver, analysisResult)
  //       .where((fix) =>
  //           fix.error.location.file == parameters.file &&
  //           fix.error.location.offset <= parameters.offset &&
  //           parameters.offset <= fix.error.location.offset + fix.error.location.length &&
  //           fix.fixes.isNotEmpty)
  //       .toList();

  //   return plugin.EditGetFixesResult(fixes);
  // } on Exception catch (e, stackTrace) {
  //   channel.sendNotification(
  //     plugin.PluginErrorParams(false, e.toString(), stackTrace.toString()).toNotification(),
  //   );

  //   return plugin.EditGetFixesResult([]);
  // }
  // }

  void _processResult(AnalysisDriver analysisDriver, ResolvedUnitResult analysisResult) {
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'test exc',
        analysisResult.content.toString(), // StackTrace.current.toString(),
      ).toNotification(),
    );

    // final String filePath = analysisResult.path ?? 'Unknown analysisResult.path';

    // try {
    //   // If there is no relevant analysis result, notify the analyzer of no errors.
    //   if (analysisResult.unit == null) {
    //     channel.sendNotification(
    //       plugin.AnalysisErrorsParams(
    //         filePath,
    //         <AnalysisError>[],
    //       ).toNotification(),
    //     );
    //   } else {
    //     // If there is something to analyze, do so and notify the analyzer.
    //     // Note that notifying with an empty set of errors is important as
    //     // this clears errors if they were fixed.
    //     final Map<AnalysisError, plugin.PrioritizedSourceChange> checkResult = _checker.checkResult(
    //       pattern: RegExp('^Test{1}'),
    //       parseResult: analysisResult,
    //     ) as Map<AnalysisError, plugin.PrioritizedSourceChange>;

    //     channel.sendNotification(
    //       plugin.AnalysisErrorsParams(
    //         filePath,
    //         checkResult.keys.toList(),
    //       ).toNotification(),
    //     );
    //   }
    // } catch (exc, stackTrace) {
    //   // Notify the analyzer that an exception happened.
    //   channel.sendNotification(
    //     plugin.PluginErrorParams(
    //       false,
    //       exc.toString(),
    //       stackTrace.toString(),
    //     ).toNotification(),
    //   );
    // }
    //
    //
    //
    // from wrike
    //     try {
    //   if (analysisResult.unit != null) {
    //     final fixes = _check(driver, analysisResult);

    //     channel.sendNotification(plugin.AnalysisErrorsParams(
    //       analysisResult.path!,
    //       fixes.map((fix) => fix.error).toList(),
    //     ).toNotification());
    //   } else {
    //     channel.sendNotification(
    //       plugin.AnalysisErrorsParams(analysisResult.path!, [])
    //           .toNotification(),
    //     );
    //   }
    // } on Exception catch (e, stackTrace) {
    //   channel.sendNotification(
    //     plugin.PluginErrorParams(false, e.toString(), stackTrace.toString())
    //         .toNotification(),
    //   );
    // }
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

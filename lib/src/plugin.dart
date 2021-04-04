import 'dart:async';

// ignore_for_file: implementation_imports
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';

import 'package:analyzer/src/context/builder.dart';
import 'package:analyzer/src/workspace/workspace.dart';
import 'package:analyzer/src/context/context_root.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:cool_linter/src/checker.dart';

class CoolLinterPlugin extends ServerPlugin {
  CoolLinterPlugin(
    ResourceProvider provider,
  ) : super(provider);

  final Checker checker = Checker();

  @override
  List<String> get fileGlobsToAnalyze => const <String>['*.dart'];

  @override
  String get name => 'app neo';

  @override
  String get version => '1.0.0';

  @override
  String get contactInfo => 'https://github.com/jWinterDay';

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
      ..analysisDriverScheduler = analysisDriverScheduler
      ..byteStore = byteStore
      ..performanceLog = performanceLog;
    // ..fileContentOverlay = fileContentOverlay;
    //

    final Workspace workspace = ContextBuilder.createWorkspace(
      resourceProvider: resourceProvider,
      options: contextBuilder.builderOptions,
      rootPath: contextRoot.root,
      lookForBazelBuildFileSubstitutes: false,
    );

    // return builder.createSourceFactory(folder.path, workspace);

    final AnalysisDriver result = contextBuilder.buildDriver(root, workspace);

    result.results.listen((ResolvedUnitResult analysisResult) {
      _processResult(result, analysisResult);
    });

    return result;
  }

  void _processResult(AnalysisDriver result, ResolvedUnitResult analysisResult) {
    try {
      // If there is no relevant analysis result, notify the analyzer of no errors.
      if (analysisResult.unit == null) {
        //} || analysisResult.libraryElement == null) {
        channel.sendNotification(
          plugin.AnalysisErrorsParams(
            analysisResult.path ?? '', // TODO
            <AnalysisError>[],
          ).toNotification(),
        );
      } else {
        // If there is something to analyze, do so and notify the analyzer.
        // Note that notifying with an empty set of errors is important as
        // this clears errors if they were fixed.
        final Map<AnalysisError, plugin.PrioritizedSourceChange> checkResult = {};
        //  = checker.check(
        //   analysisResult.libraryElement,
        // );

        channel.sendNotification(
          plugin.AnalysisErrorsParams(
            analysisResult.path ?? '', // TODO
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

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(plugin.EditGetFixesParams parameters) async {
    try {
      final ResolvedUnitResult analysisResult =
          await (driverForPath(parameters.file) as AnalysisDriver).getResult(parameters.file);

      // Get errors and fixes for the file.
      final Map<AnalysisError, plugin.PrioritizedSourceChange> checkResult =
          <AnalysisError, plugin.PrioritizedSourceChange>{};
      // checker.check(
      //   analysisResult.libraryElement,
      // );

      // Return any fixes that are for the expected file.
      final List<plugin.AnalysisErrorFixes> fixes = <plugin.AnalysisErrorFixes>[];
      for (final AnalysisError error in checkResult.keys) {
        final plugin.PrioritizedSourceChange checkResultByError = checkResult[error]!;

        if (error.location.file == parameters.file && checkResultByError.change.edits.single.edits.isNotEmpty) {
          fixes.add(plugin.AnalysisErrorFixes(
            error,
            fixes: <plugin.PrioritizedSourceChange>[checkResultByError],
          ));
        }
      }

      return plugin.EditGetFixesResult(fixes);
    } catch (exc, stackTrace) {
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          exc.toString(),
          stackTrace.toString(),
        ).toNotification(),
      );

      return plugin.EditGetFixesResult(<plugin.AnalysisErrorFixes>[]);
    }
  }
}

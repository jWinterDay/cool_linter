import 'dart:async';

// ignore_for_file: implementation_imports
// fignore_for_file: avoid_as
import 'package:analyzer/src/workspace/workspace.dart';
import 'package:glob/glob.dart';

//
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/context/builder.dart';
import 'package:analyzer/src/context/context_root.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer/src/dart/analysis/file_state.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

//
import 'package:cool_linter/src/checker.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/config/yaml_config_extension.dart';

//

class CoolLinterPlugin extends ServerPlugin {
  CoolLinterPlugin(
    ResourceProvider provider,
  ) : super(provider);

  List<String> _filesFromSetPriorityFilesRequest = <String>[];

  final Checker _checker = Checker();

  @override
  List<String> get fileGlobsToAnalyze => const <String>['*.dart'];

  @override
  String get name => 'Cool linter';

  @override
  String get version => '1.0.0-alpha.0';

  @override
  String get contactInfo => 'https://github.com/jWinterDay/cool_linter';

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
      ..performanceLog = performanceLog
      ..fileContentOverlay = FileContentOverlay();

    final Workspace workspace = ContextBuilder.createWorkspace(
      resourceProvider: resourceProvider,
      options: ContextBuilderOptions(),
      rootPath: contextRoot.root,
    );

    final AnalysisDriver analysisDriver = contextBuilder.buildDriver(root, workspace);

    // get yaml options
    final YamlConfig? yamlConfig = _getYamlConfig(analysisDriver);
    if (yamlConfig == null) {
      return analysisDriver;
    }

    final List<Glob> excludesGlobList = yamlConfig.excludesGlobList(contextRoot.root);

    runZonedGuarded(
      () {
        analysisDriver.results.listen((ResolvedUnitResult analysisResult) {
          _processResult(
            analysisDriver,
            analysisResult,
            yamlConfig: yamlConfig,
            excludesGlobList: excludesGlobList,
          );
        });
      },
      (Object e, StackTrace stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'cool_linter. Unexpected error: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
      },
    );

    return analysisDriver;
  }

  @override
  void contentChanged(String path) {
    super.driverForPath(path)?.addFile(path);
  }

  @override
  Future<plugin.AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(
    plugin.AnalysisSetContextRootsParams parameters,
  ) async {
    final plugin.AnalysisSetContextRootsResult result = await super.handleAnalysisSetContextRoots(parameters);
    // The super-call adds files to the driver, so we need to prioritize them so they get analyzed.
    // see: https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/obsoleted/analyzer_plugin/analyzer_plugin.dart
    _updatePriorityFiles();

    return result;
  }

  @override
  Future<plugin.AnalysisSetPriorityFilesResult> handleAnalysisSetPriorityFiles(
    plugin.AnalysisSetPriorityFilesParams parameters,
  ) async {
    _filesFromSetPriorityFilesRequest = parameters.files;
    _updatePriorityFiles();

    return plugin.AnalysisSetPriorityFilesResult();
  }

  void _processResult(
    AnalysisDriver analysisDriver,
    ResolvedUnitResult analysisResult, {
    required YamlConfig yamlConfig,
    required List<Glob> excludesGlobList,
  }) {
    final String? filePath = analysisResult.path;
    if (filePath == null) {
      return;
    }

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
          yamlConfig: yamlConfig,
          excludesGlobList: excludesGlobList,
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

  // see: https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/obsoleted/analyzer_plugin/analyzer_plugin.dart
  void _updatePriorityFiles() {
    final Set<String> filesToFullyResolve = <String>{
      // Ensure these go first, since they're actually considered priority; ...
      ..._filesFromSetPriorityFilesRequest,

      // ... all other files need to be analyzed, but don't trump priority
      // ignore: avoid_as
      for (final AnalysisDriverGeneric driver2 in driverMap.values) ...(driver2 as AnalysisDriver).addedFiles,
    };

    // From ServerPlugin.handleAnalysisSetPriorityFiles
    final Map<AnalysisDriverGeneric, List<String>> filesByDriver = <AnalysisDriverGeneric, List<String>>{};

    for (final String file in filesToFullyResolve) {
      final plugin.ContextRoot? contextRoot = contextRootContaining(file);

      if (contextRoot != null) {
        final AnalysisDriverGeneric driver = driverMap[contextRoot]!;
        filesByDriver.putIfAbsent(driver, () => <String>[]).add(file);
      }
    }

    filesByDriver.forEach((AnalysisDriverGeneric driver, List<String> files) {
      driver.priorityFiles = files;
    });
  }

  YamlConfig? _getYamlConfig(AnalysisDriver analysisDriver) {
    try {
      // ignore: deprecated_member_use
      final String? optionsPath = analysisDriver.contextRoot?.optionsFilePath;
      final bool isEmpty = optionsPath?.isEmpty ?? true;
      if (isEmpty) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'cool_linter. no analysis options file',
            StackTrace.current.toString(),
          ).toNotification(),
        );

        return null;
      }

      final File file = resourceProvider.getFile(optionsPath!);
      if (!file.exists) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'cool_linter. no analysis options file content',
            StackTrace.current.toString(),
          ).toNotification(),
        );

        return null;
      }

      final YamlConfig yamlConfig = YamlConfig.fromFile(file);
      if (yamlConfig.checkCorrectMessage != null) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            yamlConfig.checkCorrectMessage!,
            // 'Failed to read yaml config in analysis_options.yaml. See https://pub.dev/packages/cool_linter how to include settings',
            StackTrace.current.toString(),
          ).toNotification(),
        );

        return null;
      }

      return yamlConfig;
    } catch (exc, stackTrace) {
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          '$Exception when read yaml comfig: $exc',
          stackTrace.toString(),
        ).toNotification(),
      );

      return null;
    }
  }
}

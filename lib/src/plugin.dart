import 'dart:async';

// ignore_for_file: implementation_imports
// import 'package:analyzer/src/workspace/workspace.dart';
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:glob/glob.dart';

//
import 'package:analyzer/dart/analysis/context_builder.dart';
import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';

import 'package:analyzer/src/dart/analysis/driver.dart';

import 'package:analyzer/src/dart/analysis/driver_based_analysis_context.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;

// import 'package:analyzer/dart/analysis/results.dart';
// import 'package:analyzer/file_system/file_system.dart';
// // import 'package:analyzer/src/context/builder.dart';
// import 'package:analyzer/src/context/context_root.dart';
// import 'package:analyzer/src/dart/analysis/driver.dart';
// import 'package:analyzer_plugin/plugin/plugin.dart';
// import 'package:analyzer/src/dart/analysis/file_state.dart';
// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

//
import 'package:cool_linter/src/checker.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/config/yaml_config_extension.dart';
import 'package:path/path.dart' as p;

//

class CoolLinterPlugin extends ServerPlugin {
  CoolLinterPlugin(
    ResourceProvider provider,
  ) : super(provider);

  List<String> _filesFromSetPriorityFilesRequest = <String>[];

  static final Checker _checker = Checker();

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
    // extended excluded files
    final List<String> extendedExcludedFolders = <String>[
      '.dart_tool',
      '.vscode',
      'packages',
      'ios',
      'macos',
      'android',
      'web',
      'linux',
      'windows',
      'go',
    ].map((String f) {
      final Glob glob = Glob(p.join(contextRoot.root, f));

      return glob.toString();
    }).toList();

    final String rootPath = contextRoot.root;
    final List<ContextRoot> locator = ContextLocator(resourceProvider: resourceProvider).locateRoots(
      includedPaths: <String>[rootPath],
      excludedPaths: <String>[
        ...contextRoot.exclude,
        ...extendedExcludedFolders,
      ],
      optionsFile: contextRoot.optionsFile,
    );

    if (locator.isEmpty) {
      final StateError error = StateError('Unexpected empty context');
      channel.sendNotification(plugin.PluginErrorParams(
        true,
        error.message,
        error.stackTrace.toString(),
      ).toNotification());

      throw error;
    }

    final ContextBuilder builder = ContextBuilder(
      resourceProvider: resourceProvider,
    );

    final AnalysisContext analysisContext = builder.createContext(contextRoot: locator.first);
    // ignore: avoid_as
    final DriverBasedAnalysisContext context = analysisContext as DriverBasedAnalysisContext;
    final AnalysisDriver dartDriver = context.driver;

    // get yaml options
    final YamlConfig? yamlConfig = _getYamlConfig(dartDriver);
    if (yamlConfig == null) {
      return dartDriver;
    }

    final List<Glob> excludesGlobList = yamlConfig.excludesGlobList(contextRoot.root);

    runZonedGuarded(
      () {
        dartDriver.results.listen((ResolvedUnitResult analysisResult) {
          _processResult(
            dartDriver,
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

    return dartDriver;
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
            <plugin.AnalysisError>[],
          ).toNotification(),
        );
      } else {
        // If there is something to analyze, do so and notify the analyzer.
        // Note that notifying with an empty set of errors is important as
        // this clears errors if they were fixed.
        final Map<plugin.AnalysisError, plugin.PrioritizedSourceChange> checkResult = _checker.checkResult(
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
      final File? optionsPath = analysisDriver.analysisContext?.contextRoot.optionsFile;
      // final bool isEmpty = optionsPath?.isEmpty ?? true;
      final bool exists = optionsPath?.exists ?? false;

      if (!exists) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'cool_linter. no analysis options file',
            StackTrace.current.toString(),
          ).toNotification(),
        );

        return null;
      }

      // final File file = resourceProvider.getFile(optionsPath!);
      // if (!file.exists) {
      //   channel.sendNotification(
      //     plugin.PluginErrorParams(
      //       false,
      //       'cool_linter. no analysis options file content',
      //       StackTrace.current.toString(),
      //     ).toNotification(),
      //   );

      //   return null;
      // }

      final YamlConfig yamlConfig = YamlConfig.fromFile(optionsPath!);
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

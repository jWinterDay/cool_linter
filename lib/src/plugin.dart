// @dart=2.12

import 'dart:async';
import 'dart:convert';

// ignore_for_file: implementation_imports
// fignore_for_file: avoid_as
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/src/analysis_options/analysis_options_provider.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/context/builder.dart';
import 'package:analyzer/src/context/context_root.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:cool_linter/src/checker.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/utils/yaml_util.dart';
import 'package:yaml/src/yaml_node.dart';
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

    final AnalysisDriver analysisDriver = contextBuilder.buildDriver(root);

    // get yaml options
    final YamlConfig? yamlConfig = _getYamlConfig(analysisDriver);

    runZonedGuarded(
      () {
        analysisDriver.results.listen((ResolvedUnitResult analysisResult) {
          _processResult(analysisDriver, analysisResult, yamlConfig);
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

  void _processResult(AnalysisDriver analysisDriver, ResolvedUnitResult analysisResult, YamlConfig? yamlConfig) {
    final String filePath = analysisResult.path;

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
          // pattern: RegExp('^Test{1}'),
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

  YamlConfig? _getYamlConfig(AnalysisDriver driver) {
    try {
      final bool isEmpty = driver.contextRoot?.optionsFilePath?.isEmpty ?? true;
      if (isEmpty) {
        return null;
      }

      final File file = resourceProvider.getFile(driver.contextRoot.optionsFilePath);
      if (!file.exists) {
        return null;
      }

      final YamlMap yamlMap = AnalysisOptionsProvider(driver.sourceFactory).getOptionsFromFile(file);
      final Map<String, Object> m = yamlMapToDartMap(yamlMap);
      final YamlConfig yamlConfig = YamlConfig.fromMap(m);

      return yamlConfig;
    } catch (exc) {
      return null;
    }
  }
}

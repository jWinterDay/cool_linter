import 'dart:async';

// ignore_for_file: implementation_imports
import 'package:analyzer/dart/analysis/analysis_context.dart';
//
import 'package:analyzer/dart/analysis/context_builder.dart';
import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer/src/dart/analysis/driver_based_analysis_context.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as pg;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:cool_linter/src/checker.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

class CoolLinterPlugin extends ServerPlugin {
  CoolLinterPlugin(
    ResourceProvider provider,
  ) : super(provider);

  static const Checker _checker = Checker();

  @override
  List<String> get fileGlobsToAnalyze => const <String>['*.dart'];

  @override
  String get name => 'Cool linter';

  @override
  String get version => '1.0.0-alpha.0';

  @override
  String get contactInfo => 'https://github.com/jWinterDay/cool_linter';

  List<String> _filesFromSetPriorityFilesRequest = <String>[];
  AnalysisSettings? _analysisSettings;
  List<Glob> _excludesGlobList = <Glob>[];

  @override
  AnalysisDriverGeneric createAnalysisDriver(plugin.ContextRoot contextRoot) {
    // extended excluded files
    final List<String> extendedExcludedFolders =
        kDefaultExcludedFolders.map((String f) {
      final Glob glob = Glob(p.join(contextRoot.root, f));

      return glob.toString();
    }).toList();

    final String rootPath = contextRoot.root;
    final List<ContextRoot> locator =
        ContextLocator(resourceProvider: resourceProvider).locateRoots(
      includedPaths: <String>[rootPath],
      excludedPaths: <String>[
        ...contextRoot.exclude,
        ...extendedExcludedFolders,
      ],
      optionsFile: contextRoot.optionsFile,
    );

    if (locator.isEmpty) {
      final StateError error = StateError('Unexpected empty context');
      channel.sendNotification(
        plugin.PluginErrorParams(
          true,
          error.message,
          error.stackTrace.toString(),
        ).toNotification(),
      );

      throw error;
    }

    final ContextBuilder builder = ContextBuilder(
      resourceProvider: resourceProvider,
    );

    final AnalysisContext analysisContext =
        builder.createContext(contextRoot: locator.first);
    final DriverBasedAnalysisContext context =
        analysisContext as DriverBasedAnalysisContext;
    final AnalysisDriver dartDriver = context.driver;

    // get yaml options
    _analysisSettings = _getAnalysisSettings(dartDriver);
    if (_analysisSettings == null) {
      return dartDriver;
    }

    // final List<Glob> excludesGlobList = AnalysisSettingsUtil.excludesGlobList(contextRoot.root, _analysisSettings!);
    _excludesGlobList = AnalysisSettingsUtil.excludesGlobList(
        contextRoot.root, _analysisSettings!);

    runZonedGuarded(
      () {
        dartDriver.results.listen((Object analysisResult) {
          _processResult(
            dartDriver,
            analysisResult as ResolvedUnitResult,
            analysisSettings: _analysisSettings!,
            excludesGlobList: _excludesGlobList,
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
    final plugin.AnalysisSetContextRootsResult result =
        await super.handleAnalysisSetContextRoots(parameters);
    _updatePriorityFiles();

    return result;
    // try {
    //   final plugin.AnalysisSetContextRootsResult result = await super.handleAnalysisSetContextRoots(parameters);
    //   _updatePriorityFiles();

    //   return result;
    // } catch (exc, stackTrace) {
    //   channel.sendNotification(
    //     plugin.PluginErrorParams(
    //       false,
    //       exc.toString(),
    //       stackTrace.toString(),
    //     ).toNotification(),
    //   );

    //   rethrow;
    // }
  }

  @override
  Future<plugin.AnalysisSetPriorityFilesResult> handleAnalysisSetPriorityFiles(
    plugin.AnalysisSetPriorityFilesParams parameters,
  ) async {
    _filesFromSetPriorityFilesRequest = parameters.files;
    _updatePriorityFiles();

    return plugin.AnalysisSetPriorityFilesResult();
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    try {
      final AnalysisDriver driver =
          driverForPath(parameters.file) as AnalysisDriver;
      final SomeResolvedUnitResult analysisResult =
          await driver.getResult(parameters.file);

      if (analysisResult is! ResolvedUnitResult) {
        return plugin.EditGetFixesResult(<pg.AnalysisErrorFixes>[]);
      }

      if (_analysisSettings == null) {
        return plugin.EditGetFixesResult(<pg.AnalysisErrorFixes>[]);
      }

      final Iterable<plugin.AnalysisErrorFixes> checkResult =
          _checker.checkResult(
        analysisSettings: _analysisSettings!,
        excludesGlobList: _excludesGlobList,
        parseResult: analysisResult,
      );

      return plugin.EditGetFixesResult(checkResult.toList());
    } on Exception catch (e, stackTrace) {
      channel.sendNotification(
        plugin.PluginErrorParams(false, e.toString(), stackTrace.toString())
            .toNotification(),
      );

      return plugin.EditGetFixesResult(<pg.AnalysisErrorFixes>[]);
    }
  }

  void _processResult(
    AnalysisDriver analysisDriver,
    ResolvedUnitResult analysisResult, {
    required AnalysisSettings analysisSettings,
    required List<Glob> excludesGlobList,
  }) {
    final String? filePath = analysisResult.path;
    if (filePath == null) {
      return;
    }

    try {
      // If there is something to analyze, do so and notify the analyzer.
      // Note that notifying with an empty set of errors is important as
      // this clears errors if they were fixed.
      final Iterable<plugin.AnalysisErrorFixes> checkResult =
          _checker.checkResult(
        analysisSettings: analysisSettings,
        excludesGlobList: excludesGlobList,
        parseResult: analysisResult,
      );

      channel.sendNotification(
        plugin.AnalysisErrorsParams(
          filePath,
          checkResult.map((plugin.AnalysisErrorFixes e) {
            return e.error;
          }).toList(),
        ).toNotification(),
      );
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
      for (final AnalysisDriverGeneric driver2 in driverMap.values)
        ...(driver2 as AnalysisDriver).addedFiles,
    };

    // From ServerPlugin.handleAnalysisSetPriorityFiles
    final Map<AnalysisDriverGeneric, List<String>> filesByDriver =
        <AnalysisDriverGeneric, List<String>>{};

    for (final String file in filesToFullyResolve) {
      final plugin.ContextRoot? contextRoot = contextRootContaining(file);

      if (contextRoot != null) {
        final AnalysisDriverGeneric driver = driverMap[contextRoot]!;
        filesByDriver.putIfAbsent(driver, () => <String>[]).add(file);
      }
    }

    for (final MapEntry<AnalysisDriverGeneric, List<String>> item
        in filesByDriver.entries) {
      item.key.priorityFiles = item.value;
    }
  }

  AnalysisSettings? _getAnalysisSettings(AnalysisDriver analysisDriver) {
    try {
      final File? optionsPath =
          analysisDriver.analysisContext?.contextRoot.optionsFile;
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

      final AnalysisSettings? analysisSettings =
          AnalysisSettingsUtil.getAnalysisSettingsFromFile(optionsPath);

      if (analysisSettings?.coolLinter == null) {
        final StringBuffer sb = StringBuffer()
          ..writeln('Wrong cool_linter configuration')
          ..writeln('No valid cool_linter settings in analysis_options.yaml')
          ..writeln('See https://pub.dev/packages/cool_linter')
          ..writeln('analysis_options.yaml: $analysisSettings');

        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            sb.toString(),
            StackTrace.current.toString(),
          ).toNotification(),
        );

        return null;
      }

      return analysisSettings;
    } catch (exc, stackTrace) {
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          '$Exception when read yaml config: $exc',
          stackTrace.toString(),
        ).toNotification(),
      );

      return null;
    }
  }
}

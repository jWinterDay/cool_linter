// ignore_for_file: avoid_print
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_rule.dart';
import 'package:cool_linter/src/rules/prefer_trailing_comma/prefer_trailing_comma_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/rules/stream_subscription_rule/stream_subscription_rule.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:cool_linter/src/utils/ansi_colors.dart';
import 'package:cool_linter/src/utils/file_utils.dart';
import 'package:path/path.dart' as p;

class AnalyzeCommand extends Command<void> {
  AnalyzeCommand({
    required this.excludedExtensions,
  }) {
    argParser
      ..addMultiOption(
        'directories',
        abbr: 'd',
        help: 'Folder to analyze',
        defaultsTo: <String>['lib'],
      )
      ..addOption(
        'break_on',
        abbr: 'b',
        defaultsTo: '2',
      )
      ..addFlag(
        'always_specify_types',
        abbr: 't',
        help: 'Use always_specify_types_rule rule',
      )
      ..addFlag(
        'prefer_trailing_comma',
        abbr: 'c',
        help: 'Use prefer_trailing_comma rule',
      )
      ..addFlag(
        'always_specify_stream_subscription',
        abbr: 's',
        help: 'Use always_specify_stream_subscription rule',
      );
  }

  final List<String> excludedExtensions;

  @override
  String get description => 'cool_linter analyze command';

  @override
  String get name => 'analyze';

  @override
  String get invocation => '${runner?.executableName} $name [arguments] <directories>';

  @override
  Future<void> run() async {
    // ignore: avoid_as
    final List<String> dirList = argResults?['directories'] as List<String>;
    // ignore: avoid_as
    final bool alwaysSpecifyTypesRule = argResults?['always_specify_types'] as bool;
    // ignore: avoid_as
    final bool preferTrailingCommaRule = argResults?['prefer_trailing_comma'] as bool;
    // ignore: avoid_as
    final bool alwaysSpecifyStreamSubscriptionRule = argResults?['always_specify_stream_subscription'] as bool;
    // ignore: avoid_as
    final String breakOnStr = argResults?['break_on'] as String;

    final int? breakOn = int.tryParse(breakOnStr);
    if (breakOn == null) {
      throw UsageException('Param break_on must be an integer', '-b 25');
    }

    // print('dirList = $dirList');
    // print('preferTrailingCommaRule = $preferTrailingCommaRule');
    // print('alwaysSpecifyTypesRule = $alwaysSpecifyTypesRule');
    // print('alwaysSpecifyStreamSubscriptionRule = $alwaysSpecifyStreamSubscriptionRule');
    // print('breakOn = $breakOn');

    // work
    final String rootFolder = Directory.current.path;
    final AnalysisContextCollection analysisContext = AnalysisContextCollection(
      includedPaths: dirList.map((String path) {
        return p.normalize(p.join(rootFolder, path));
      }).toList(),
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    final Set<String> filePaths = FileUtil.getDartFilesFromFolders(
      dirList,
      rootFolder,
      excludedExtensions: excludedExtensions,
    );

    // print
    final Iterable<AnalysisContext> singleContextList = analysisContext.contexts.take(1);
    final Set<Rule> rules = _createRules(
      alwaysSpecifyStreamSubscriptionRule: alwaysSpecifyStreamSubscriptionRule,
      alwaysSpecifyTypesRule: alwaysSpecifyTypesRule,
      preferTrailingCommaRule: preferTrailingCommaRule,
    );
    final AnalysisSettings analysisSettings = _createAnalysisSettings(
      alwaysSpecifyStreamSubscriptionRule: alwaysSpecifyStreamSubscriptionRule,
      alwaysSpecifyTypesRule: alwaysSpecifyTypesRule,
      preferTrailingCommaRule: preferTrailingCommaRule,
      breakOn: breakOn,
    );
    final bool wasError = await _print(
      analysisSettings: analysisSettings,
      filePaths: filePaths,
      rules: rules,
      singleContextList: singleContextList,
    );

    if (wasError) {
      exit(1);
    }
  }

  AnalysisSettings _createAnalysisSettings({
    bool alwaysSpecifyTypesRule = false,
    bool preferTrailingCommaRule = false,
    bool alwaysSpecifyStreamSubscriptionRule = false,
    int breakOn = 2,
  }) {
    final StringBuffer sb = StringBuffer();
    sb.writeln('\ncool_linter:');
    if (alwaysSpecifyStreamSubscriptionRule) {
      sb.writeln('  extended_rules:');
      sb.writeln('    - always_specify_stream_subscription');
    }

    if (alwaysSpecifyTypesRule) {
      sb.writeln('  always_specify_types:');
      sb.writeln('    - typed_literal');
      sb.writeln('    - declared_identifier');
      sb.writeln('    - set_or_map_literal');
      sb.writeln('    - simple_formal_parameter');
      sb.writeln('    - type_name');
      sb.writeln('    - variable_declaration_list');
    }

    if (preferTrailingCommaRule) {
      sb.writeln('  prefer_trailing_comma:');
      sb.writeln('    break-on: $breakOn');
    }

    return AnalysisSettings.fromJson(
      AnalysisSettingsUtil.convertYamlToMap(
        sb.toString(),
      ),
    );
  }

  Set<Rule> _createRules({
    bool alwaysSpecifyTypesRule = false,
    bool preferTrailingCommaRule = false,
    bool alwaysSpecifyStreamSubscriptionRule = false,
  }) {
    return <Rule>{
      if (alwaysSpecifyTypesRule) AlwaysSpecifyTypesRule(),
      if (preferTrailingCommaRule) PreferTrailingCommaRule(),
      if (alwaysSpecifyStreamSubscriptionRule) StreamSubscriptionRule(),
    };
  }

  Future<bool> _print({
    required Iterable<AnalysisContext> singleContextList,
    required Set<String> filePaths,
    required AnalysisSettings analysisSettings,
    required Set<Rule> rules,
  }) async {
    final IOSink iosink = stdout;
    bool wasError = false;
    int totalWarnings = 0;

    for (final AnalysisContext analysisContext in singleContextList) {
      for (final String path in filePaths) {
        // print('----path = $path');

        final SomeResolvedUnitResult unit = await analysisContext.currentSession.getResolvedUnit2(path);

        if (unit is! ResolvedUnitResult) {
          continue;
        }

        final Iterable<RuleMessage> messageList = rules.map((Rule rule) {
          return rule.check(
            parseResult: unit,
            analysisSettings: analysisSettings,
          );
        }).expand((List<RuleMessage> e) {
          return e;
        });

        for (final RuleMessage message in messageList) {
          iosink.writeln(AnsiColors.prepareRuleForPrint(message));
        }

        totalWarnings += messageList.length;

        if (messageList.isNotEmpty) {
          wasError = true;
        }
      }
    }

    iosink.writeln(AnsiColors.totalWarningsPrint(totalWarnings));

    return wasError;
  }
}

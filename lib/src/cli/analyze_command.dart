// ignore_for_file: avoid_print
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:args/command_runner.dart';
import 'package:cool_linter/src/cli/models/regexp_settings.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_rule.dart';
import 'package:cool_linter/src/rules/prefer_trailing_comma/prefer_trailing_comma_rule.dart';
import 'package:cool_linter/src/rules/regexp_rule/regexp_rule.dart';
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
      ..addFlag(
        'fix',
        abbr: 'f',
        help: 'Fix issues',
      )
      ..addFlag(
        'always_specify_types',
        abbr: 't',
        help: 'Use always_specify_types_rule rule',
      )
      ..addFlag(
        'always_specify_stream_subscription',
        abbr: 's',
        help: 'Use always_specify_stream_subscription rule',
      )
      ..addFlag(
        'prefer_trailing_comma',
        abbr: 'c',
        help: 'Use prefer_trailing_comma rule',
      )
      ..addOption(
        'regexp_path',
        help: 'Path to file with RegExp settings',
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
    final bool fix = argResults?['fix'] as bool;
    // ignore: avoid_as
    final bool alwaysSpecifyTypesRule = argResults?['always_specify_types'] as bool;

    // ignore: avoid_as
    final bool alwaysSpecifyStreamSubscriptionRule = argResults?['always_specify_stream_subscription'] as bool;
    // ignore: avoid_as
    final String? regexpPath = argResults?['regexp_path'] as String?;

    // ignore: avoid_as
    final bool preferTrailingCommaRule = argResults?['prefer_trailing_comma'] as bool;

    RegexpSettings? regexpSettings;
    if (regexpPath != null) {
      regexpSettings = _getCliRegExpSettingsFromFile(regexpPath);
    }

    AnsiColors.cliSettingsPrint('directories', dirList);
    AnsiColors.cliSettingsPrint('prefer_trailing_comma', preferTrailingCommaRule);
    AnsiColors.cliSettingsPrint('always_specify_types', alwaysSpecifyTypesRule);
    AnsiColors.cliSettingsPrint('always_specify_stream_subscription', alwaysSpecifyStreamSubscriptionRule);
    AnsiColors.cliSettingsPrint('regexp_path', regexpPath);

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

    final Iterable<AnalysisContext> singleContextList = analysisContext.contexts.take(1);

    final AnalysisSettings analysisSettings = _createAnalysisSettings(
      alwaysSpecifyStreamSubscriptionRule: alwaysSpecifyStreamSubscriptionRule,
      alwaysSpecifyTypesRule: alwaysSpecifyTypesRule,
      preferTrailingCommaRule: preferTrailingCommaRule,
      regexpSettings: regexpSettings,
    );

    if (fix) {
      await _fix(
        analysisSettings: analysisSettings,
        filePaths: filePaths,
        singleContextList: singleContextList,
      );
      return;
    }

    final bool wasError = await _print(
      analysisSettings: analysisSettings,
      filePaths: filePaths,
      singleContextList: singleContextList,
    );

    if (wasError) {
      exit(1);
    }
  }

  RegexpSettings? _getCliRegExpSettingsFromFile(String path) {
    final File file = File(path);

    if (!file.existsSync()) {
      throw UsageException('File doesn"t exist', 'Use correct file path');
    }

    final String content = file.readAsStringSync();
    return RegexpSettings.fromJson(
      AnalysisSettingsUtil.convertYamlToMap(
        content,
      ),
    );
  }

  AnalysisSettings _createAnalysisSettings({
    bool alwaysSpecifyTypesRule = false,
    bool preferTrailingCommaRule = false,
    bool alwaysSpecifyStreamSubscriptionRule = false,
    RegexpSettings? regexpSettings,
  }) {
    const String indent = '  ';
    final StringBuffer sb = StringBuffer();
    sb.writeln('\ncool_linter:');

    if (alwaysSpecifyStreamSubscriptionRule || preferTrailingCommaRule) {
      sb.writeln('${indent}extended_rules:');
    }
    if (alwaysSpecifyStreamSubscriptionRule) {
      sb.writeln('$indent$indent- always_specify_stream_subscription');
    }
    if (preferTrailingCommaRule) {
      sb.writeln('$indent$indent- prefer_trailing_comma');
    }

    if (alwaysSpecifyTypesRule) {
      sb.writeln('${indent}always_specify_types:');
      // sb.writeln('    - typed_literal');
      sb.writeln('$indent$indent- declared_identifier'); // OK
      // sb.writeln('    - set_or_map_literal');
      sb.writeln('$indent$indent- simple_formal_parameter'); // OK
      // sb.writeln('    - type_name');
      sb.writeln('$indent$indent- variable_declaration_list'); // OK
    }

    // regexp
    if (regexpSettings != null && regexpSettings.existsAtLeastOneRegExp) {
      sb.writeln('${indent}regexp_exclude:');

      for (final ExcludeWord regExpExclude in regexpSettings.regexpExcludeSafeList) {
        sb.writeln('$indent$indent-');
        sb.writeln('$indent$indent${indent}pattern: ${regExpExclude.pattern}');
        sb.writeln('$indent$indent${indent}hint: ${regExpExclude.hint}');
        sb.writeln('$indent$indent${indent}severity: ${regExpExclude.severity}');
      }
    }

    return AnalysisSettings.fromJson(
      AnalysisSettingsUtil.convertYamlToMap(
        sb.toString(),
      ),
    );
  }

  Future<bool> _print({
    required Iterable<AnalysisContext> singleContextList,
    required Set<String> filePaths,
    required AnalysisSettings analysisSettings,
  }) async {
    final Set<Rule> rules = <Rule>{
      if (analysisSettings.useAlwaysSpecifyTypes) AlwaysSpecifyTypesRule(),
      if (analysisSettings.usePreferTrailingComma) PreferTrailingCommaRule(),
      if (analysisSettings.useAlwaysSpecifyStreamSub) StreamSubscriptionRule(),
      if (analysisSettings.useRegexpExclude) RegExpRule(),
    };

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
          // print(
          //   'col: [${message.location.startColumn}:${message.location.endColumn}] line:[${message.location.startLine}] offset = ${message.location.offset}',
          // );
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

  Future<void> _fix({
    required Iterable<AnalysisContext> singleContextList,
    required Set<String> filePaths,
    required AnalysisSettings analysisSettings,
  }) async {
    final Set<Rule> rules = <Rule>{
      if (analysisSettings.useAlwaysSpecifyTypes) AlwaysSpecifyTypesRule(),
      if (analysisSettings.usePreferTrailingComma) PreferTrailingCommaRule(),
    };

    final IOSink iosink = stdout;

    for (final AnalysisContext analysisContext in singleContextList) {
      for (final String path in filePaths) {
        final SomeResolvedUnitResult unit = await analysisContext.currentSession.getResolvedUnit2(path);

        if (unit is! ResolvedUnitResult) {
          continue;
        }
        if (unit.content == null) {
          continue;
        }

        for (final Rule rule in rules) {
          final List<RuleMessage> messageList = rule.check(
            parseResult: unit,
            analysisSettings: analysisSettings,
          );

          // need work here
          final String content = unit.content!;
          final StringBuffer sb = StringBuffer();
          final File correctFile = File(unit.path!);

          int prevPosition = 0;
          for (int i = 0; i < messageList.length; i++) {
            final RuleMessage message = messageList.elementAt(i);

            // print(
            //   '$i ${messageList.length} |||| prevPosition = $prevPosition start = ${message.location.offset} end = ${message.location.offset + message.location.length}',
            // );

            final String strLeftPart = content.substring(prevPosition, message.location.offset);

            sb.write(strLeftPart);
            if (message.correction == null) {
              final String originalVal = content.substring(
                message.location.offset,
                message.location.offset + message.location.length,
              );
              sb.write(originalVal);
            } else {
              sb.write(message.correction);
            }

            prevPosition = message.location.offset + message.location.length;

            if (i == messageList.length - 1) {
              sb.write(content.substring(prevPosition));
            }

            await correctFile.writeAsString(sb.toString(), flush: i == 0);
            iosink.writeln(AnsiColors.prepareRuleForPrint(message));
          }
        }
      }
    }
  }
}

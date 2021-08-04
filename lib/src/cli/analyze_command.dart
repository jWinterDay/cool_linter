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
    argParser.addMultiOption(
      'directories',
      abbr: 'd',
      help: 'Folder to analyze',
      defaultsTo: <String>['lib'],
    );
    // ..addOption(
    //   'fix',
    //   abbr: 'f',
    //   help: 'Rules',
    //   defaultsTo: 'always_specify_types',
    // );
  }

  final List<String> excludedExtensions;

  @override
  String get description => 'cool_linter analyze command';

  @override
  String get name => 'analyze';

  @override
  String get invocation => '${runner?.executableName} $name [arguments] <directories>';

  // TODO
  static final Set<Rule> _rules = <Rule>{
    AlwaysSpecifyTypesRule(),
    PreferTrailingCommaRule(),
    // RegExpRule(),
    StreamSubscriptionRule(),
  };

  // TODO
  static final AnalysisSettings _analysisSettings = AnalysisSettings.fromJson(
    AnalysisSettingsUtil.convertYamlToMap(
      r'''
          cool_linter:
            extended_rules:
              - always_specify_stream_subscription
              - prefer_trailing_comma
            always_specify_types:
              - typed_literal
              - declared_identifier
              - set_or_map_literal
              - simple_formal_parameter
              - type_name
              - variable_declaration_list
        ''',
    ),
  );

  // regexp_exclude:
  //             -
  //               pattern: TestClass
  //               hint: Wrong name
  //               severity: WARNING

  @override
  Future<void> run() async {
    final ArgResults? arg = argResults;

    // ignore: avoid_as
    final List<String> dirList = argResults?['directories'] as List<String>;

    // work
    final String rootFolder = Directory.current.path;
    // final File analysisOptionsFile = File(p.absolute(rootFolder, 'analysis_options.yaml'));

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
    final IOSink iosink = stdout;
    bool wasError = false;

    final Iterable<AnalysisContext> singleContextList = analysisContext.contexts.take(1);

    await Future.forEach(singleContextList, (AnalysisContext analysisContext) async {
      await Future.forEach(filePaths, (String path) async {
        // print('----path = $path');

        final SomeResolvedUnitResult unit = await analysisContext.currentSession.getResolvedUnit2(path);

        if (unit is! ResolvedUnitResult) {
          return;
        }

        final Iterable<RuleMessage> messageList = _rules.map((Rule rule) {
          return rule.check(
            parseResult: unit,
            analysisSettings: _analysisSettings,
          );
        }).expand((List<RuleMessage> e) {
          return e;
        });

        await Future.forEach(messageList, (RuleMessage message) async {
          iosink.writeln(AnsiColors.prepareRuleForPrint(message));
        });

        if (messageList.isNotEmpty) {
          wasError = true;
        }
      });
    });

    if (wasError) {
      exit(1);
    }
  }
}

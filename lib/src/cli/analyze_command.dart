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
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:cool_linter/src/utils/file_utils.dart';
import 'package:path/path.dart' as p;

class AnalyzeCommand extends Command<void> {
  AnalyzeCommand({
    required this.excludedExtensions,
  }) {
    // argParser.addOption(
    //   'root',
    //   help: 'Root folder.',
    //   valueHelp: './',
    //   defaultsTo: Directory.current.path,
    // );
    // ..addSeparator('')
    // ..addOption(
    //   'directories',
    //   abbr: 'd',
    //   help: 'Folder to analyze',
    //   defaultsTo: 'lib',
    // )
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
  static final List<Rule> _rules = <Rule>[
    AlwaysSpecifyTypesRule(),
  ];

  // TODO
  static final AnalysisSettings _analysisSettings = AnalysisSettings.fromJson(
    AnalysisSettingsUtil.convertYamlToMap(
      r'''
          cool_linter:
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

  @override
  Future<void> run() async {
    final ArgResults? arg = argResults;

    print('----arg = ${arg?.arguments}');

    // TODO
    const List<String> folderToAnalyseList = <String>['lib'];
    final String rootFolder = Directory.current.path;
    // final File analysisOptionsFile = File(p.absolute(rootFolder, 'analysis_options.yaml'));

    final AnalysisContextCollection analysisContext = AnalysisContextCollection(
      includedPaths: folderToAnalyseList.map((String path) {
        return p.normalize(p.join(rootFolder, path));
      }).toList(),
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    final Set<String> filePaths = FileUtil.getDartFilesFromFolders(
      folderToAnalyseList,
      rootFolder,
      excludedExtensions: excludedExtensions,
    );

    analysisContext.contexts.forEach((AnalysisContext analysisContext) {
      filePaths.forEach((String path) async {
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

        messageList.forEach((RuleMessage message) {
          print('----${message.message} > ${message.location.file} > ${message.location.startLine}');
        });

        if (messageList.isNotEmpty) {
          exit(1);
        }
      });
    });
  }
}

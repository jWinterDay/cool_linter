// ignore_for_file: avoid_print
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cool_linter/src/utils/file_utils.dart';
import 'package:path/path.dart' as p;

class AnalyzeCommand extends Command<void> {
  AnalyzeCommand() {
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

  @override
  String get description => 'cool_linter analyze command';

  @override
  String get name => 'analyze';

  @override
  String get invocation => '${runner?.executableName} $name [arguments] <directories>';

  @override
  Future<void> run() async {
    final ArgResults? arg = argResults;

    print('----arg = ${arg?.arguments}');

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
    );

    analysisContext.contexts.forEach((AnalysisContext analysisContext) {
      filePaths.forEach((String path) async {
        final SomeResolvedUnitResult unit = await analysisContext.currentSession.getResolvedUnit2(path);

        if (unit is ResolvedUnitResult) {
          print('---${unit.runtimeType} ---${unit.path}');
          // final result = _runAnalysisForFile(
          //   unit,
          //   lintAnalysisConfig,
          //   rootFolder,
          //   filePath: filePath,
          // );

          // if (result != null) {
          //   analyzerResult.add(result);
          // }
        }
      });
      // final contextConfig = ConfigBuilder.getLintConfigFromOptions(analysisOptions).merge(config);
    });
  }
}

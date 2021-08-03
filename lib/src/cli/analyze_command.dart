// ignore_for_file: avoid_print
import 'package:args/args.dart';
import 'package:args/command_runner.dart';

class AnalyzeCommand extends Command<void> {
  AnalyzeCommand() {
    // argParser
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
  }
}

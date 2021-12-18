// ignore_for_file: avoid_print
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cool_linter/src/cli/analyze_command.dart';
import 'package:cool_linter/src/utils/ansi_colors.dart';

// static List<Glob> excludesGlobList(String root, AnalysisSettings analysisSettings) {
//   final Iterable<String> patterns = analysisSettings.coolLinter?.excludeFolders ?? <String>[];

//   return <String>[
//     ...kDefaultExcludedFoldersYaml,
//     ...patterns,
//   ].map((String folder) {
//     return Glob(p.join(root, folder));
//   }).toList();
// }

List<String> excludedExtensions = <String>[
  '.g.dart',
  '.freezed.dart',

  // TODO
  'l10n.dart',
  'messages_all.dart',
  'messages_en.dart',
  'messages_ru.dart',
];

Future<void> main(List<String> args) async {
  try {
    final CommandRunner<void> runner =
        CommandRunner<void>('cool_linter', 'cool_linter cli')
          ..addCommand(
            AnalyzeCommand(
              excludedExtensions: excludedExtensions,
            ),
          );

    await runner.run(args);
  } on UsageException catch (exc) {
    stderr.writeln(
        '${AnsiColors.red}${exc.message}. Usage: ${AnsiColors.green}${exc.usage}${AnsiColors.reset}');
    // print('${AnsiColors.red}${exc.message}. Usage: ${AnsiColors.green}${exc.usage}${AnsiColors.reset}');
    exit(64);
  } on Exception catch (exc) {
    stderr.writeln('Uunexpected error: $exc');
    exit(1);
  }
}

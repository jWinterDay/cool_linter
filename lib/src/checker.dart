// @dart=2.12

// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

class IncorrectLineInfo {
  IncorrectLineInfo({
    required this.line,
    required this.excludeWord,
  });

  final int line;
  final ExcludeWord excludeWord;
}

class Checker {
  List<IncorrectLineInfo>? getIncorrectLines(String src, YamlConfig? yamlConfig) {
    final List<ExcludeWord> patterns = yamlConfig?.coolLinter?.excludeWords ?? <ExcludeWord>[];
    if (patterns.isEmpty) {
      return null;
    }

    final List<RegExp> regExpPatternList = patterns.map((ExcludeWord excludeWord) {
      return RegExp(excludeWord.pattern!);
    }).toList();

    final List<IncorrectLineInfo> matchListInfo = <IncorrectLineInfo>[];

    try {
      final ParseStringResult parseResult = parseString(
        content: src,
        featureSet: FeatureSet.fromEnableFlags2(
          sdkLanguageVersion: Version.parse('2.12.0'),
          flags: <String>[],
        ),
        throwIfDiagnostics: false,
      );

      final List<int> lineStarts = parseResult.lineInfo.lineStarts;
      int prevIndex = 0;
      int columnIndex = 0;

      lineStarts.forEach((int lineStartIndex) {
        if (lineStartIndex == 0) return;

        final String lineStr = src.substring(prevIndex, lineStartIndex);
        prevIndex = lineStartIndex;

        // is comment
        final bool isComment = lineStr.trimLeft().startsWith('//');
        if (isComment) {
          columnIndex++;
          return;
        }

        // patterns
        final bool hasError = regExpPatternList.any(lineStr.contains);

        if (hasError) {
          final ExcludeWord firstExcludedWord = patterns.firstWhere((ExcludeWord excludeWord) {
            final RegExp re = RegExp(excludeWord.pattern!);

            return lineStr.contains(re);
          });

          matchListInfo.add(IncorrectLineInfo(
            line: columnIndex + 1,
            excludeWord: firstExcludedWord,
          ));
        }

        columnIndex++;
      });

      return matchListInfo;
    } catch (exc) {
      return null; //<int>[];
    }
  }

  Map<AnalysisError, PrioritizedSourceChange> checkResult({
    YamlConfig? yamlConfig,
    required ResolvedUnitResult parseResult,
    AnalysisErrorSeverity? errorSeverity = AnalysisErrorSeverity.WARNING,
  }) {
    final Map<AnalysisError, PrioritizedSourceChange> result = <AnalysisError, PrioritizedSourceChange>{};

    if (parseResult.content == null) {
      return result;
    }

    final List<IncorrectLineInfo>? incorrectLinesInfo = getIncorrectLines(parseResult.content!, yamlConfig);

    if (incorrectLinesInfo == null || incorrectLinesInfo.isEmpty) {
      return result;
    }

    // loop through all wrong lines
    incorrectLinesInfo.forEach((IncorrectLineInfo incorrectLineInfo) {
      // fix
      final PrioritizedSourceChange fix = PrioritizedSourceChange(
        1000000,
        SourceChange(
          'Apply fixes for cool_linter.',
          edits: <SourceFileEdit>[
            SourceFileEdit(
              'TODO fn', // parseResult.unit?.declaredElement?.source.fullName ?? 'todo filename',
              1, //parseResult.unit?.declaredElement?.source.modificationStamp ?? 1,
              edits: <SourceEdit>[
                SourceEdit(1, 2, 'cool_linter. need to replace by pattern:'), // $pattern'),
              ],
            )
          ],
        ),
      );

      // error
      final AnalysisError error = AnalysisError(
        AnalysisErrorSeverity(incorrectLineInfo.excludeWord.safeSeverity),
        AnalysisErrorType.LINT,
        Location(
          'TODO fn', //parseResult.unit?.declaredElement?.source.fullName ?? 'todo filename',
          1, // offset
          1, // length
          incorrectLineInfo.line,
          1, // startColumn
          // 1, // endLine
          // 1, // endColumn
        ),
        // 'Need fixes for cool_linter pattern: ${incorrectLineInfo.excludeWord.hint}',
        'cool_linter. ${incorrectLineInfo.excludeWord} for pattern: ${incorrectLineInfo.excludeWord.hint}',
        'cool_linter_needs_fixes',
      );

      result[error] = fix;
    });

    return result;
  }
}

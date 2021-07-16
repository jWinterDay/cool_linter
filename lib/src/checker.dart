import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:glob/glob.dart';
import 'package:cool_linter/src/config/yaml_config_extension.dart';

class IncorrectLineInfo {
  IncorrectLineInfo({
    required this.line,
    required this.excludeWord,
  });

  final int line;
  final ExcludeWord excludeWord;

  @override
  String toString() {
    return 'line: $line excludeWord: $excludeWord';
  }
}

class Checker {
  const Checker();

  List<IncorrectLineInfo> getIncorrectLines(String src, YamlConfig yamlConfig) {
    final List<ExcludeWord> patterns = yamlConfig.coolLinter?.excludeWords ?? <ExcludeWord>[];
    if (patterns.isEmpty) {
      return <IncorrectLineInfo>[];
    }

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
        if (lineStartIndex == 0) {
          return;
        }

        final String lineStr = src.substring(prevIndex, lineStartIndex);
        prevIndex = lineStartIndex;

        // is comment
        final bool isComment = lineStr.trimLeft().startsWith('//');
        if (isComment) {
          columnIndex++;
          return;
        }

        // find first pattern
        final Iterable<ExcludeWord> excludedWordList = patterns.where(
          (ExcludeWord excludeWord) {
            if (excludeWord.pattern == null) {
              return false;
            }

            final RegExp re = RegExp(excludeWord.pattern!);

            return lineStr.contains(re);
          },
        );

        if (excludedWordList.isNotEmpty) {
          final ExcludeWord firstExcluded = excludedWordList.first;

          matchListInfo.add(IncorrectLineInfo(
            line: columnIndex + 1,
            excludeWord: firstExcluded,
          ));
        }

        columnIndex++;
      });

      return matchListInfo;
    } catch (exc) {
      return <IncorrectLineInfo>[];
    }
  }

  Map<AnalysisError, PrioritizedSourceChange> checkResult({
    required YamlConfig yamlConfig,
    required List<Glob> excludesGlobList,
    required ResolvedUnitResult parseResult,
    AnalysisErrorSeverity errorSeverity = AnalysisErrorSeverity.WARNING,
  }) {
    final Map<AnalysisError, PrioritizedSourceChange> result = <AnalysisError, PrioritizedSourceChange>{};

    if (parseResult.content == null || parseResult.path == null) {
      return result;
    }

    final bool isExcluded = yamlConfig.isExcluded(parseResult, excludesGlobList);
    if (isExcluded) {
      return result;
    }

    final List<IncorrectLineInfo> incorrectLinesInfo = getIncorrectLines(parseResult.content!, yamlConfig);

    if (incorrectLinesInfo.isEmpty) {
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
              parseResult.path!,
              1, //parseResult.unit?.declaredElement?.source.modificationStamp ?? 1,
              edits: <SourceEdit>[
                SourceEdit(1, 2, 'cool_linter. need to replace by pattern:'), // $pattern'),
              ],
            )
          ],
        ),
      );

      // error
      final String hint = incorrectLineInfo.excludeWord.hint ?? '';

      final AnalysisError error = AnalysisError(
        AnalysisErrorSeverity(incorrectLineInfo.excludeWord.safeSeverity),
        AnalysisErrorType.LINT,
        Location(
          parseResult.path!,
          1, // offset
          1, // length
          incorrectLineInfo.line,
          1, // startColumn
          1, // endLine
          1, //incorrectLineInfo.lineText.length, // endColumn
        ),
        'cool_linter. $hint for pattern: ${incorrectLineInfo.excludeWord.pattern}',
        'cool_linter_needs_fixes',
      );

      result[error] = fix;
    });

    return result;
  }
}

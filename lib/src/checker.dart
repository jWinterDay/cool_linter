import 'package:analyzer/dart/analysis/results.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer_plugin_fork/protocol/protocol_common.dart';
import 'package:analyzer_plugin_fork/protocol/protocol_generated.dart';
// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

class Checker {
  List<int> getIncorrectLines(String src, Pattern pattern) {
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
    final List<int> matchIndexList = <int>[];

    lineStarts.forEach((int lineStartIndex) {
      if (lineStartIndex == 0) return;

      final String lineStr = src.substring(prevIndex, lineStartIndex);
      prevIndex = lineStartIndex;

      // is comment
      final bool isComment = lineStr.trimLeft().startsWith('//');

      if (!isComment && lineStr.contains(pattern)) {
        matchIndexList.add(columnIndex);
      }

      columnIndex++;
    });

    return matchIndexList;
  }

  Map<AnalysisError, PrioritizedSourceChange> checkResult({
    required Pattern pattern,
    // required ParseStringResult parseResult,
    required ResolvedUnitResult parseResult,
    AnalysisErrorSeverity? errorSeverity = AnalysisErrorSeverity.WARNING,
  }) {
    final Map<AnalysisError, PrioritizedSourceChange> result = <AnalysisError, PrioritizedSourceChange>{};

    if (parseResult.content == null) {
      return result;
    }

    // final List<int> incorrectLines = getIncorrectLines(parseResult.content!, pattern);

    // if (incorrectLines.isEmpty) {
    //   return result;
    // }

    // loop through all wrong lines

    // final units = parseResult.libraryElement.units.first.source;

    // parseResult.unit.declaredElement.source

    // incorrectLines.forEach((int lineIndex) {
    final PrioritizedSourceChange fix = PrioritizedSourceChange(
      1000000,
      SourceChange(
        'Apply fixes for cool_linter.',
        edits: <SourceFileEdit>[
          SourceFileEdit(
            'TODO fn', // parseResult.unit?.declaredElement?.source.fullName ?? 'todo filename',
            parseResult.unit?.declaredElement?.source.modificationStamp ?? 1,
            edits: <SourceEdit>[
              SourceEdit(1, 2, 'cool_linter. need to replace by pattern: $pattern'),
            ],
          )
        ],
      ),
    );

    final AnalysisError error = AnalysisError(
      errorSeverity ?? AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.LINT,
      Location(
        'TODO fn', //parseResult.unit?.declaredElement?.source.fullName ?? 'todo filename',
        1, // offset
        1, // length
        666, //lineIndex, // startLine
        1, // startColumn
        // 1, // endLine
        // 1, // endColumn
      ),
      'Need fixes for cool_linter pattern: $pattern',
      'cool_linter_needs_fixes',
    );

    result[error] = fix;
    // });

    return result as Map<AnalysisError, PrioritizedSourceChange>;
  }
}

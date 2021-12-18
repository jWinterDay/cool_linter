import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/source/line_info.dart';

import 'ast_analyze_result.dart';

extension AstAnalyzeResultIgnoreFilter on AstAnalyzeResult {
  bool filterByIgnore({
    required AstAnalyzeResult visitorMessage,
    required ResolvedUnitResult parseResult,
    required Iterable<int> ignoreColumnList,
  }) {
    final int offset = visitorMessage.astNode.offset;
    final CharacterLocation offsetLocation =
        parseResult.lineInfo.getLocation(offset);
    final int warningLineNumber = offsetLocation.lineNumber;

    final bool willIgnoreNextLine =
        ignoreColumnList.any((int ignoreLineNumber) {
      return ignoreLineNumber + 1 == warningLineNumber;
    });

    return !willIgnoreNextLine;
  }
}

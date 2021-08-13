import 'package:analyzer/dart/analysis/results.dart';

import 'ast_analyze_result.dart';

extension AstAnalyzeResultIgnoreFilter on AstAnalyzeResult {
  bool filterByIgnore({
    required AstAnalyzeResult visitorMessage,
    required ResolvedUnitResult parseResult,
    required Iterable<int> ignoreColumnList,
  }) {
    final int offset = visitorMessage.astNode.offset;
    // ignore: always_specify_types
    final offsetLocation = parseResult.lineInfo.getLocation(offset);
    final int warningLineNumber = offsetLocation.lineNumber;

    final bool willIgnoreNextLine = ignoreColumnList.any((int ignoreLineNumber) {
      return ignoreLineNumber + 1 == warningLineNumber;
    });

    return !willIgnoreNextLine;
  }
}

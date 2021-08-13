import 'package:analyzer/dart/ast/ast.dart';
import 'package:cool_linter/src/rules/ast_analyze_result.dart';

// TODO
class RegExpResult extends AstAnalyzeResult {
  RegExpResult({
    required AstNode astNode,
  }) : super(astNode: astNode);
}

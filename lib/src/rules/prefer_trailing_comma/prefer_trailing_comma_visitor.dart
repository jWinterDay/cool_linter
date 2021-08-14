import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'prefer_trailing_comma_result.dart';

class PreferTrailingCommaVisitor extends RecursiveAstVisitor<void> {
  PreferTrailingCommaVisitor(
    this.rule, {
    this.breakpoint = 2,
    required this.lineInfo,
  });

  final Rule rule;

  final int? breakpoint;
  final LineInfo lineInfo;

  final List<PreferTrailingCommaResult> _visitorRuleMessages = <PreferTrailingCommaResult>[];
  List<PreferTrailingCommaResult> get visitorRuleMessages => _visitorRuleMessages;

  @override
  void visitArgumentList(ArgumentList node) {
    super.visitArgumentList(node);

    _visitNodeList(node.arguments, node.leftParenthesis, node.rightParenthesis);
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    super.visitFormalParameterList(node);

    _visitNodeList(
      node.parameters,
      node.leftParenthesis,
      node.rightParenthesis,
    );
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    super.visitEnumDeclaration(node);

    _visitNodeList(node.constants, node.leftBracket, node.rightBracket);
  }

  @override
  void visitListLiteral(ListLiteral node) {
    super.visitListLiteral(node);

    _visitNodeList(node.elements, node.leftBracket, node.rightBracket);
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral node) {
    super.visitSetOrMapLiteral(node);

    _visitNodeList(node.elements, node.leftBracket, node.rightBracket);
  }

  void _visitNodeList(
    Iterable<AstNode> nodes,
    Token leftBracket,
    Token rightBracket,
  ) {
    if (nodes.isEmpty) {
      return;
    }

    final AstNode last = nodes.last;

    final bool lastItemIsNotComma = last.endToken.next?.type != TokenType.COMMA;
    final bool lastItemMultiLine = !_isLastItemMultiLine(last, leftBracket, rightBracket);
    final bool differentLineNumbers = _getLineNumber(leftBracket) != _getLineNumber(rightBracket);
    final bool nodesMoreThanBreakpoint = breakpoint != null && nodes.length >= breakpoint!;

    if (lastItemIsNotComma && (lastItemMultiLine && differentLineNumbers || nodesMoreThanBreakpoint)) {
      _visitorRuleMessages.add(PreferTrailingCommaResult(
        astNode: last,
      ));
    }
  }

  bool _isLastItemMultiLine(
    AstNode node,
    Token leftBracket,
    Token rightBracket,
  ) {
    return _getLineNumber(leftBracket) == lineInfo.getLocation(node.offset).lineNumber &&
        _getLineNumber(rightBracket) == lineInfo.getLocation(node.end).lineNumber;
  }

  int _getLineNumber(SyntacticEntity entity) {
    return lineInfo.getLocation(entity.offset).lineNumber;
  }
}

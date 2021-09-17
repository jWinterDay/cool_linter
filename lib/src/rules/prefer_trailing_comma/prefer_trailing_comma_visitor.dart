import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'prefer_trailing_comma_result.dart';

class PreferTrailingCommaVisitor extends RecursiveAstVisitor<void> {
  PreferTrailingCommaVisitor(
    this.rule, {
    required this.lineInfo,
  });

  final Rule rule;
  final LineInfo lineInfo;

  final List<PreferTrailingCommaResult> _visitorRuleMessages = <PreferTrailingCommaResult>[];
  List<PreferTrailingCommaResult> get visitorRuleMessages => _visitorRuleMessages;

  // @override
  // void visitCompilationUnit(CompilationUnit node) {
  //   _lineInfo = node.lineInfo;
  // }

  @override
  void visitArgumentList(ArgumentList node) {
    super.visitArgumentList(node);

    if (node.arguments.isEmpty) {
      return;
    }

    _checkTrailingComma(
      node.leftParenthesis,
      node.rightParenthesis,
      node.arguments.last,
    );
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    super.visitFormalParameterList(node);

    if (node.parameters.isEmpty) {
      return;
    }

    _checkTrailingComma(
      node.leftParenthesis,
      node.rightParenthesis,
      node.parameters.last,
    );
  }

  @override
  void visitAssertStatement(AssertStatement node) {
    super.visitAssertStatement(node);

    _checkTrailingComma(
      node.leftParenthesis,
      node.rightParenthesis,
      node.message ?? node.condition,
    );
  }

  @override
  void visitAssertInitializer(AssertInitializer node) {
    super.visitAssertInitializer(node);

    _checkTrailingComma(
      node.leftParenthesis,
      node.rightParenthesis,
      node.message ?? node.condition,
    );
  }

  void _checkTrailingComma(
    Token leftParenthesis,
    Token rightParenthesis,
    AstNode lastNode,
  ) {
    // Early exit if trailing comma is present.
    if (lastNode.endToken.next?.type == TokenType.COMMA) {
      return;
    }

    // No trailing comma is needed if the function call or declaration, up to
    // the closing parenthesis, fits on a single line. Ensuring the left and
    // right parenthesis are on the same line is sufficient since dartfmt places
    // the left parenthesis right after the identifier (on the same line).
    if (_isSameLine(leftParenthesis, rightParenthesis)) {
      return;
    }

    // Check the last parameter to determine if there are any exceptions.
    if (_shouldAllowTrailingCommaException(lastNode)) {
      return;
    }

    // rule.reportLintForToken(rightParenthesis, errorCode: _trailingCommaCode);
    _visitorRuleMessages.add(
      PreferTrailingCommaResult(
        astNode: lastNode,
      ),
    );
  }

  bool _isSameLine(Token token1, Token token2) {
    return lineInfo.getLocation(token1.offset).lineNumber == lineInfo.getLocation(token2.offset).lineNumber;
  }

  bool _shouldAllowTrailingCommaException(AstNode lastNode) {
    // No exceptions are allowed if the last parameter is named.
    if (lastNode is FormalParameter && lastNode.isNamed) return false;

    // No exceptions are allowed if the entire last parameter fits on one line.
    if (_isSameLine(lastNode.beginToken, lastNode.endToken)) return false;

    // Exception is allowed if the last parameter is a function literal.
    if (lastNode is FunctionExpression && lastNode.body is BlockFunctionBody) {
      return true;
    }

    // Exception is allowed if the last parameter is a set, map or list literal.
    if (lastNode is SetOrMapLiteral || lastNode is ListLiteral) return true;

    return false;
  }
}

// class PreferTrailingCommaVisitor extends RecursiveAstVisitor<void> {
//   PreferTrailingCommaVisitor(
//     this.rule, {
//     this.breakpoint = 2,
//     required this.lineInfo,
//   });

//   final Rule rule;

//   final int? breakpoint;
//   final LineInfo lineInfo;

//   final List<PreferTrailingCommaResult> _visitorRuleMessages = <PreferTrailingCommaResult>[];
//   List<PreferTrailingCommaResult> get visitorRuleMessages => _visitorRuleMessages;

//   @override
//   void visitArgumentList(ArgumentList node) {
//     super.visitArgumentList(node);

//     _visitNodeList(node.arguments, node.leftParenthesis, node.rightParenthesis);
//   }

//   @override
//   void visitFormalParameterList(FormalParameterList node) {
//     super.visitFormalParameterList(node);

//     _visitNodeList(
//       node.parameters,
//       node.leftParenthesis,
//       node.rightParenthesis,
//     );
//   }

//   @override
//   void visitEnumDeclaration(EnumDeclaration node) {
//     super.visitEnumDeclaration(node);

//     _visitNodeList(node.constants, node.leftBracket, node.rightBracket);
//   }

//   @override
//   void visitListLiteral(ListLiteral node) {
//     super.visitListLiteral(node);

//     _visitNodeList(node.elements, node.leftBracket, node.rightBracket);
//   }

//   @override
//   void visitSetOrMapLiteral(SetOrMapLiteral node) {
//     super.visitSetOrMapLiteral(node);

//     _visitNodeList(node.elements, node.leftBracket, node.rightBracket);
//   }

//   void _visitNodeList(
//     Iterable<AstNode> nodes,
//     Token leftBracket,
//     Token rightBracket,
//   ) {
//     if (nodes.isEmpty) {
//       return;
//     }

//     final AstNode last = nodes.last;

//     final bool lastItemIsNotComma = last.endToken.next?.type != TokenType.COMMA;
//     final bool lastItemMultiLine = !_isLastItemMultiLine(last, leftBracket, rightBracket);
//     final bool differentLineNumbers = _getLineNumber(leftBracket) != _getLineNumber(rightBracket);
//     final bool nodesMoreThanBreakpoint = breakpoint != null && nodes.length >= breakpoint!;

//     if (lastItemIsNotComma && (lastItemMultiLine && differentLineNumbers || nodesMoreThanBreakpoint)) {
//       _visitorRuleMessages.add(PreferTrailingCommaResult(
//         astNode: last,
//       ));
//     }
//   }

//   bool _isLastItemMultiLine(
//     AstNode node,
//     Token leftBracket,
//     Token rightBracket,
//   ) {
//     return _getLineNumber(leftBracket) == lineInfo.getLocation(node.offset).lineNumber &&
//         _getLineNumber(rightBracket) == lineInfo.getLocation(node.end).lineNumber;
//   }

//   int _getLineNumber(SyntacticEntity entity) {
//     return lineInfo.getLocation(entity.offset).lineNumber;
//   }
// }

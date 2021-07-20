import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'prefer_image_cache_sizes_result.dart';

class PreferImageCacheSizesVisitor extends RecursiveAstVisitor<void> {
  PreferImageCacheSizesVisitor(this.rule);

  final Rule rule;

  final List<PreferImageCacheSizesResult> _visitorRuleMessages = <PreferImageCacheSizesResult>[];
  List<PreferImageCacheSizesResult> get visitorRuleMessages => _visitorRuleMessages;

  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    super.visitDeclaredIdentifier(node);

    print('--0 $node');

    // if (node.type == null) {
    //   _visitorRuleMessages.add(PreferImageCacheSizesResult(
    //     astNode: node,
    //   ));
    //   // print('++++ visitDeclaredIdentifier: ${node}');
    // }
  }

  @override
  void visitExpressionStatement(ExpressionStatement node) {
    super.visitExpressionStatement(node);

    print('--1 $node');

    // if (node.expression.staticType?.element?.displayName == _kStreamSubscriptionName) {
    //   _visitorRuleMessages.add(StreamSubscriptionResult(
    //     astNode: node,
    //   ));
    // }

    // print('[----8----] visitExpressionStatement: ${node.expression.staticType?.element?.displayName}');
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    super.visitMethodDeclaration(node);

    print('--2 $node');
  }

  @override
  void visitExpressionFunctionBody(ExpressionFunctionBody node) {
    print('--3 $node');
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    print('--4 $node');
  }

  @override
  void visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node) {
    print('--5 $node');
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    print('--6 $node');
  }

  @override
  void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) {
    print('--7 $node');
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    print('--8 $node');
  }

  @override
  void visitNamedExpression(NamedExpression node) {
    print('--9 $node');
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    print('--10 $node');
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    print('--11 $node');
  }

  @override
  void visitTypeArgumentList(TypeArgumentList node) {
    print('--12 $node');
  }

  @override
  void visitTypeParameter(TypeParameter node) {
    print('--13 $node');
  }

  @override
  void visitTypeParameterList(TypeParameterList node) {
    print('--14 $node');
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    print('--15 $node');
  }

  @override
  void visitVariableDeclarationList(VariableDeclarationList node) {
    print('--16 $node');
  }
}

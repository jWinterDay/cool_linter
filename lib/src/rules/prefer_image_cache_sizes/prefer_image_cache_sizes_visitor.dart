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

  @override
  void visitArgumentList(ArgumentList node) {
    print('+++17: $node');
  }

  @override
  void visitAsExpression(AsExpression node) {
    print('+++18: $node');
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    print('+++19: $node');
  }

  @override
  void visitBlock(Block node) {
    print('+++20: $node');
  }

  @override
  void visitBlockFunctionBody(BlockFunctionBody node) {
    print('+++21: $node');
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    print('+++22: $node');
  }

  @override
  void visitClassTypeAlias(ClassTypeAlias node) {
    print('+++23: $node');
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    print('+++24: $node');
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    print('+++25: $node');
  }

  @override
  void visitConfiguration(Configuration node) {
    print('+++26: $node');
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    print('+++27: $node');
  }

  @override
  void visitConstructorFieldInitializer(ConstructorFieldInitializer node) {
    print('+++28: $node');
  }

  @override
  void visitConstructorName(ConstructorName node) {
    print('+++29: $node');
  }

  @override
  void visitConstructorReference(ConstructorReference node) {
    print('+++30: $node');
  }

  @override
  void visitDefaultFormalParameter(DefaultFormalParameter node) {
    print('+++31: $node');
  }

  @override
  void visitFieldFormalParameter(FieldFormalParameter node) {
    print('+++32: $node');
  }
}

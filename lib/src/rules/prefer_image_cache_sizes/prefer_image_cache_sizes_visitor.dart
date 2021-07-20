import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'prefer_image_cache_sizes_result.dart';

class PreferImageCacheSizesVisitor extends RecursiveAstVisitor<void> {
  PreferImageCacheSizesVisitor(this.rule);

  final Rule rule;

  final List<PreferImageCacheSizesResult> _visitorRuleMessages = <PreferImageCacheSizesResult>[];
  List<PreferImageCacheSizesResult> get visitorRuleMessages => _visitorRuleMessages;

  // @override
  // void visitDeclaredIdentifier(DeclaredIdentifier node) {
  //   super.visitDeclaredIdentifier(node);

  //   print('--0 $node');

  //   // if (node.type == null) {
  //   //   _visitorRuleMessages.add(PreferImageCacheSizesResult(
  //   //     astNode: node,
  //   //   ));
  //   //   // print('++++ visitDeclaredIdentifier: ${node}');
  //   // }
  // }

  // @override
  // void visitExpressionStatement(ExpressionStatement node) {
  //   super.visitExpressionStatement(node);

  //   print('--1 $node');

  //   // if (node.expression.staticType?.element?.displayName == _kStreamSubscriptionName) {
  //   //   _visitorRuleMessages.add(StreamSubscriptionResult(
  //   //     astNode: node,
  //   //   ));
  //   // }

  //   // print('[----8----] visitExpressionStatement: ${node.expression.staticType?.element?.displayName}');
  // }

  // @override
  // void visitMethodDeclaration(MethodDeclaration node) {
  //   super.visitMethodDeclaration(node);

  //   print('--2 $node');
  // }

  // @override
  // void visitExpressionFunctionBody(ExpressionFunctionBody node) {
  //   print('--3 $node');
  // }

  // @override
  // void visitFieldDeclaration(FieldDeclaration node) {
  //   print('--4 $node');
  // }

  // @override
  // void visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node) {
  //   print('--5 $node');
  // }

  // @override
  // void visitFormalParameterList(FormalParameterList node) {
  //   print('--6 $node');
  // }

  // @override
  // void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) {
  //   print('--7 $node');
  // }

  // @override
  // void visitMethodInvocation(MethodInvocation node) {
  //   print('--8 $node');
  // }

  // @override
  // void visitNamedExpression(NamedExpression node) {
  //   print('--9 $node');
  // }

  // @override
  // void visitSimpleFormalParameter(SimpleFormalParameter node) {
  //   print('--10 $node');
  // }

  // @override
  // void visitSimpleIdentifier(SimpleIdentifier node) {
  //   print('--11 $node');
  // }

  // @override
  // void visitTypeArgumentList(TypeArgumentList node) {
  //   print('--12 $node');
  // }

  // @override
  // void visitTypeParameter(TypeParameter node) {
  //   print('--13 $node');
  // }

  // @override
  // void visitTypeParameterList(TypeParameterList node) {
  //   print('--14 $node');
  // }

  // @override
  // void visitVariableDeclaration(VariableDeclaration node) {
  //   print('--15 $node');
  // }

  // @override
  // void visitVariableDeclarationList(VariableDeclarationList node) {
  //   print('--16 $node');
  // }

  // @override
  // void visitArgumentList(ArgumentList node) {
  //   print('+++17: $node');
  // }

  // @override
  // void visitAsExpression(AsExpression node) {
  //   print('+++18: $node');
  // }

  // @override
  // void visitAssignmentExpression(AssignmentExpression node) {
  //   print('+++19: $node');
  // }

  // @override
  // void visitBlock(Block node) {
  //   print('+++20: $node');
  // }

  // @override
  // void visitBlockFunctionBody(BlockFunctionBody node) {
  //   print('+++21: $node');
  // }

  // @override
  // void visitClassDeclaration(ClassDeclaration node) {
  //   print('+++22: $node');
  // }

  // @override
  // void visitClassTypeAlias(ClassTypeAlias node) {
  //   print('+++23: $node');
  // }

  // @override
  // void visitCompilationUnit(CompilationUnit node) {
  //   print('+++24: $node');
  // }

  // @override
  // void visitConditionalExpression(ConditionalExpression node) {
  //   print('+++25: $node');
  // }

  // @override
  // void visitConfiguration(Configuration node) {
  //   print('+++26: $node');
  // }

  // @override
  // void visitConstructorDeclaration(ConstructorDeclaration node) {
  //   print('+++27: $node');
  // }

  // @override
  // void visitConstructorFieldInitializer(ConstructorFieldInitializer node) {
  //   print('+++28: $node');
  // }

  // @override
  // void visitConstructorName(ConstructorName node) {
  //   print('+++29: $node');
  // }

  // @override
  // void visitConstructorReference(ConstructorReference node) {
  //   print('+++30: $node');
  // }

  // @override
  // void visitDefaultFormalParameter(DefaultFormalParameter node) {
  //   print('+++31: $node');
  // }

  // @override
  // void visitFieldFormalParameter(FieldFormalParameter node) {
  //   print('+++32: $node');
  // }

  // @override
  // void visitCascadeExpression(CascadeExpression node) {
  //   print('+++33: $node');
  //   // final bool parentContainsName = node.staticType?.element?.displayName == _kStreamSubscriptionName;

  //   // final bool childContainsName = node.cascadeSections.any((Expression e) {
  //   //   return e.staticType?.element?.displayName == _kStreamSubscriptionName;
  //   // });

  //   // if (!parentContainsName && childContainsName) {
  //   //   _visitorRuleMessages.add(StreamSubscriptionResult(
  //   //     astNode: node,
  //   //   ));
  //   // }

  //   // print('[----21----] visitCascadeExpression: ${node.target.staticType?.element?.displayName}');
  //   // node.cascadeSections.forEach((Expression e) {
  //   //   print('[----21----] forEach: ${e.staticType} >${e.isAssignable} > $e');
  //   // });
  // }

  // @override
  // void visitExtensionDeclaration(ExtensionDeclaration node) {
  //   print('+++34: $node');
  // }

  // @override
  // void visitFunctionDeclaration(FunctionDeclaration node) {
  //   print('+++35: $node');
  // }

  // // ======
  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    print('visitAdjacentStrings>> $node');
  }

  @override
  void visitAnnotation(Annotation node) {
    print('visitAnnotation>> $node');
  }

  @override
  void visitArgumentList(ArgumentList node) {
    print('visitArgumentList>> $node');
  }

  @override
  void visitAsExpression(AsExpression node) {
    print('visitAsExpression>> $node');
  }

  @override
  void visitAssertInitializer(AssertInitializer node) {
    print('visitAssertInitializer>> $node');
  }

  @override
  void visitAssertStatement(AssertStatement node) {
    print('>> $node');
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    print('visitAssignmentExpression>> $node');
  }

  @override
  void visitAwaitExpression(AwaitExpression node) {
    print('visitAwaitExpression>> $node');
  }

  @override
  void visitBinaryExpression(BinaryExpression node) {
    print('visitBinaryExpression>> $node');
  }

  @override
  void visitBlock(Block node) {
    print('visitBlock>> $node');
  }

  @override
  void visitBlockFunctionBody(BlockFunctionBody node) {
    print('visitBlockFunctionBody>> $node');
  }

  @override
  void visitBooleanLiteral(BooleanLiteral node) {
    print('visitBooleanLiteral>> $node');
  }

  @override
  void visitBreakStatement(BreakStatement node) {
    print('visitBreakStatement>> $node');
  }

  @override
  void visitCascadeExpression(CascadeExpression node) {
    print('visitCascadeExpression>> $node');
  }

  @override
  void visitCatchClause(CatchClause node) {
    print('visitCatchClause>> $node');
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    print('visitClassDeclaration>> $node');
  }

  @override
  void visitClassTypeAlias(ClassTypeAlias node) {
    print('visitClassTypeAlias>> $node');
  }

  @override
  void visitComment(Comment node) {
    print('visitComment>> $node');
  }

  @override
  void visitCommentReference(CommentReference node) {
    print('visitCommentReference>> $node');
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    print('visitCompilationUnit>> $node');
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    print('visitConditionalExpression>> $node');
  }

  @override
  void visitConfiguration(Configuration node) {
    print('visitConfiguration>> $node');
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    print('visitConstructorDeclaration>> $node');
  }

  @override
  void visitConstructorFieldInitializer(ConstructorFieldInitializer node) {
    print('visitConstructorFieldInitializer>> $node');
  }

  @override
  void visitConstructorName(ConstructorName node) {
    print('visitConstructorName>> $node');
  }

  @override
  void visitConstructorReference(ConstructorReference node) {
    print('visitConstructorReference>> $node');
  }

  @override
  void visitContinueStatement(ContinueStatement node) {
    print('visitContinueStatement>> $node');
  }

  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    print('visitDeclaredIdentifier>> $node');
  }

  @override
  void visitDefaultFormalParameter(DefaultFormalParameter node) {
    print('visitDefaultFormalParameter>> $node');
  }

  @override
  void visitDoStatement(DoStatement node) {
    print('visitDoStatement>> $node');
  }

  @override
  void visitDottedName(DottedName node) {
    print('visitDottedName>> $node');
  }

  @override
  void visitDoubleLiteral(DoubleLiteral node) {
    print('visitDoubleLiteral>> $node');
  }

  @override
  void visitEmptyFunctionBody(EmptyFunctionBody node) {
    print('visitEmptyFunctionBody>> $node');
  }

  @override
  void visitEmptyStatement(EmptyStatement node) {
    print('visitEmptyStatement>> $node');
  }

  @override
  void visitEnumConstantDeclaration(EnumConstantDeclaration node) {
    print('visitEnumConstantDeclaration>> $node');
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    print('visitEnumDeclaration>> $node');
  }

  @override
  void visitExportDirective(ExportDirective node) {
    print('visitExportDirective>> $node');
  }

  @override
  void visitExpressionFunctionBody(ExpressionFunctionBody node) {
    print('visitExpressionFunctionBody>> $node');
  }

  @override
  void visitExpressionStatement(ExpressionStatement node) {
    print('visitExpressionStatement>> $node');
  }

  @override
  void visitExtendsClause(ExtendsClause node) {
    print('visitExtendsClause>> $node');
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    print('visitExtensionDeclaration>> $node');
  }

  @override
  void visitExtensionOverride(ExtensionOverride node) {
    print('visitExtensionOverride>> $node');
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    print('visitFieldDeclaration>> $node');
  }

  @override
  void visitFieldFormalParameter(FieldFormalParameter node) {
    print('visitFieldFormalParameter>> $node');
  }

  @override
  void visitForEachPartsWithDeclaration(ForEachPartsWithDeclaration node) {
    print('visitForEachPartsWithDeclaration>> $node');
  }

  @override
  void visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node) {
    print('visitForEachPartsWithIdentifier>> $node');
  }

  @override
  void visitForElement(ForElement node) {
    print('visitForElement>> $node');
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    print('visitFormalParameterList>> $node');
  }

  @override
  void visitForPartsWithDeclarations(ForPartsWithDeclarations node) {
    print('visitForPartsWithDeclarations>> $node');
  }

  @override
  void visitForPartsWithExpression(ForPartsWithExpression node) {
    print('visitForPartsWithExpression>> $node');
  }

  @override
  void visitForStatement(ForStatement node) {
    print('visitForStatement>> $node');
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    print('visitFunctionDeclaration>> $node');
  }

  @override
  void visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    print('visitFunctionDeclarationStatement>> $node');
  }

  @override
  void visitFunctionExpression(FunctionExpression node) {
    print('visitFunctionExpression>> $node');
  }

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    print('visitFunctionExpressionInvocation>> $node');
  }

  @override
  void visitFunctionReference(FunctionReference node) {
    print('visitFunctionReference>> $node');
  }

  @override
  void visitFunctionTypeAlias(FunctionTypeAlias node) {
    print('visitFunctionTypeAlias>> $node');
  }

  @override
  void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) {
    print('visitFunctionTypedFormalParameter>> $node');
  }

  @override
  void visitGenericFunctionType(GenericFunctionType node) {
    print('visitGenericFunctionType>> $node');
  }

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    print('visitGenericTypeAlias>> $node');
  }

  @override
  void visitHideCombinator(HideCombinator node) {
    print('visitHideCombinator>> $node');
  }

  @override
  void visitIfElement(IfElement node) {
    print('visitIfElement>> $node');
  }

  @override
  void visitIfStatement(IfStatement node) {
    print('visitIfStatement>> $node');
  }

  @override
  void visitImplementsClause(ImplementsClause node) {
    print('visitImplementsClause>> $node');
  }

  @override
  void visitImportDirective(ImportDirective node) {
    print('visitImportDirective>> $node');
  }

  @override
  void visitIndexExpression(IndexExpression node) {
    print('visitIndexExpression>> $node');
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    print('visitInstanceCreationExpression>> $node');
  }

  @override
  void visitIntegerLiteral(IntegerLiteral node) {
    print('visitIntegerLiteral>> $node');
  }

  @override
  void visitInterpolationExpression(InterpolationExpression node) {
    print('visitInterpolationExpression>> $node');
  }

  @override
  void visitInterpolationString(InterpolationString node) {
    print('visitInterpolationString>> $node');
  }

  @override
  void visitIsExpression(IsExpression node) {
    print('visitIsExpression>> $node');
  }

  @override
  void visitLabel(Label node) {
    print('visitLabel>> $node');
  }

  @override
  void visitLabeledStatement(LabeledStatement node) {
    print('visitLabeledStatement>> $node');
  }

  @override
  void visitLibraryDirective(LibraryDirective node) {
    print('visitLibraryDirective>> $node');
  }

  @override
  void visitLibraryIdentifier(LibraryIdentifier node) {
    print('visitLibraryIdentifier>> $node');
  }

  @override
  void visitListLiteral(ListLiteral node) {
    print('visitListLiteral>> $node');
  }

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    print('visitMapLiteralEntry>> $node');
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    print('visitMethodDeclaration>> $node');
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    print('visitMethodInvocation>> $node');
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    print('visitMixinDeclaration>> $node');
  }

  @override
  void visitNamedExpression(NamedExpression node) {
    print('visitNamedExpression>> $node');
  }

  @override
  void visitNativeClause(NativeClause node) {
    print('visitNativeClause>> $node');
  }

  @override
  void visitNativeFunctionBody(NativeFunctionBody node) {
    print('visitNativeFunctionBody>> $node');
  }

  @override
  void visitNullLiteral(NullLiteral node) {
    print('visitNullLiteral>> $node');
  }

  @override
  void visitOnClause(OnClause node) {
    print('visitOnClause>> $node');
  }

  @override
  void visitParenthesizedExpression(ParenthesizedExpression node) {
    print('visitParenthesizedExpression>> $node');
  }

  @override
  void visitPartDirective(PartDirective node) {
    print('visitPartDirective>> $node');
  }

  @override
  void visitPartOfDirective(PartOfDirective node) {
    print('visitPartOfDirective>> $node');
  }

  @override
  void visitPostfixExpression(PostfixExpression node) {
    print('visitPostfixExpression>> $node');
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    print('visitPrefixedIdentifier>> $node');
  }

  @override
  void visitPrefixExpression(PrefixExpression node) {
    print('visitPrefixExpression>> $node');
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    print('visitPropertyAccess>> $node');
  }

  @override
  void visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node) {
    print('visitRedirectingConstructorInvocation>> $node');
  }

  @override
  void visitRethrowExpression(RethrowExpression node) {
    print('visitRethrowExpression>> $node');
  }

  @override
  void visitReturnStatement(ReturnStatement node) {
    print('visitReturnStatement>> $node');
  }

  @override
  void visitScriptTag(ScriptTag node) {
    print('visitScriptTag>> $node');
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral node) {
    print('visitSetOrMapLiteral>> $node');
  }

  @override
  void visitShowCombinator(ShowCombinator node) {
    print('visitShowCombinator>> $node');
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    print('visitSimpleFormalParameter>> $node');
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    print('visitSimpleIdentifier>> $node');
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    print('visitSimpleStringLiteral>> $node');
  }

  @override
  void visitSpreadElement(SpreadElement node) {
    print('visitSpreadElement>> $node');
  }

  @override
  void visitStringInterpolation(StringInterpolation node) {
    print('visitStringInterpolation>> $node');
  }

  @override
  void visitSuperConstructorInvocation(SuperConstructorInvocation node) {
    print('visitSuperConstructorInvocation>> $node');
  }

  @override
  void visitSuperExpression(SuperExpression node) {
    print('visitSuperExpression>> $node');
  }

  @override
  void visitSwitchCase(SwitchCase node) {
    print('visitSwitchCase>> $node');
  }

  @override
  void visitSwitchDefault(SwitchDefault node) {
    print('visitSwitchDefault>> $node');
  }

  @override
  void visitSwitchStatement(SwitchStatement node) {
    print('visitSwitchStatement>> $node');
  }

  @override
  void visitSymbolLiteral(SymbolLiteral node) {
    print('visitSymbolLiteral>> $node');
  }

  @override
  void visitThisExpression(ThisExpression node) {
    print('visitThisExpression>> $node');
  }

  @override
  void visitThrowExpression(ThrowExpression node) {
    print('visitThrowExpression>> $node');
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    print('visitTopLevelVariableDeclaration>> $node');
  }

  @override
  void visitTryStatement(TryStatement node) {
    print('visitTryStatement>> $node');
  }

  @override
  void visitTypeArgumentList(TypeArgumentList node) {
    print('visitTypeArgumentList>> $node');
  }

  @override
  void visitTypeLiteral(TypeLiteral node) {
    print('visitTypeLiteral>> $node');
  }

  @override
  void visitTypeName(TypeName node) {
    print('visitTypeName>> $node');
  }

  @override
  void visitTypeParameter(TypeParameter node) {
    print('visitTypeParameter>> $node');
  }

  @override
  void visitTypeParameterList(TypeParameterList node) {
    print('visitTypeParameterList>> $node');
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    print('visitVariableDeclaration>> $node');
  }

  @override
  void visitVariableDeclarationList(VariableDeclarationList node) {
    print('visitVariableDeclarationList>> $node');
  }

  @override
  void visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    print('visitVariableDeclarationStatement>> $node');
  }

  @override
  void visitWhileStatement(WhileStatement node) {
    print('visitWhileStatement>> $node');
  }

  @override
  void visitWithClause(WithClause node) {
    print('visitWithClause>> $node');
  }

  @override
  void visitYieldStatement(YieldStatement node) {
    print('visitYieldStatement>> $node');
  }
}

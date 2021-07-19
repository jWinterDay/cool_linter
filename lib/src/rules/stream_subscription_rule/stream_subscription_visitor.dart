import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'stream_subscription_result.dart';

// String _metaLibName = 'meta';
// bool _isOptionalTypeArgs(Element? element) =>
//     element is PropertyAccessorElement &&
//     // element.name == _optionalTypeArgsVarName &&
//     element.library.name == _metaLibName;

class StreamSubscriptionVisitor extends RecursiveAstVisitor<void> {
  StreamSubscriptionVisitor(this.rule);

  final Rule rule;

  final List<StreamSubscriptionResult> _visitorRuleMessages = <StreamSubscriptionResult>[];
  List<StreamSubscriptionResult> get visitorRuleMessages => _visitorRuleMessages;

  // ---
  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    super.visitDeclaredIdentifier(node);

    print('[----0----] visitDeclaredIdentifier: ${node}');
  }

  // ---
  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    super.visitSimpleFormalParameter(node);

    print('[----1----] visitSimpleFormalParameter: ${node}');
  }

  // ---
  @override
  void visitTypeName(TypeName node) {
    super.visitTypeName(node);

    print('[----2----] visitTypeName: ${node}');
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    super.visitVariableDeclaration(node);

    print('[----3----] visitVariableDeclaration: ${node}');
  }
}

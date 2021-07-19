import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'stream_subscription_result.dart';

const String _kStreamSubscriptionName = 'StreamSubscription';

class StreamSubscriptionVisitor extends RecursiveAstVisitor<void> {
  StreamSubscriptionVisitor(this.rule);

  final Rule rule;

  final List<StreamSubscriptionResult> _visitorRuleMessages = <StreamSubscriptionResult>[];
  List<StreamSubscriptionResult> get visitorRuleMessages => _visitorRuleMessages;

  @override
  void visitExpressionStatement(ExpressionStatement node) {
    super.visitExpressionStatement(node);

    if (node.expression.staticType?.element?.displayName == _kStreamSubscriptionName) {
      _visitorRuleMessages.add(StreamSubscriptionResult(
        astNode: node,
      ));
    }

    // print('[----8----] visitExpressionStatement: ${node.expression.staticType?.element?.displayName}');
  }

  @override
  void visitCascadeExpression(CascadeExpression node) {
    final bool parentContainsName = node.staticType?.element?.displayName == _kStreamSubscriptionName;

    final bool childContainsName = node.cascadeSections.any((Expression e) {
      return e.staticType?.element?.displayName == _kStreamSubscriptionName;
    });

    if (!parentContainsName && childContainsName) {
      _visitorRuleMessages.add(StreamSubscriptionResult(
        astNode: node,
      ));
    }

    // print('[----21----] visitCascadeExpression: ${node.target.staticType?.element?.displayName}');
    // node.cascadeSections.forEach((Expression e) {
    //   print('[----21----] forEach: ${e.staticType} >${e.isAssignable} > $e');
    // });
  }
}

import 'package:analyzer/dart/ast/ast.dart';

class StreamSubscriptionResult {
  const StreamSubscriptionResult({
    required this.astNode,
  });

  final AstNode astNode;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer()..writeln('astNode: ${astNode.toString()}');

    return sb.toString();
  }
}

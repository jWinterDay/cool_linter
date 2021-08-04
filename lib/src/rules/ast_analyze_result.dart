import 'package:analyzer/dart/ast/ast.dart';

abstract class AstAnalyzeResult {
  AstAnalyzeResult({
    required this.astNode,
  });

  final AstNode astNode;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer()..writeln('astNode: ${astNode.toString()}');

    return sb.toString();
  }
}

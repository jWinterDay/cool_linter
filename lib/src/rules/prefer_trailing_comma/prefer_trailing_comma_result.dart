import 'package:analyzer/dart/ast/ast.dart';

class PreferTrailingCommaResult {
  const PreferTrailingCommaResult({
    required this.astNode,
  });

  final AstNode astNode;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer()..writeln('astNode: ${astNode.toString()}');

    return sb.toString();
  }
}

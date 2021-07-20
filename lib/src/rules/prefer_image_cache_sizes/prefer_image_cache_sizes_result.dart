import 'package:analyzer/dart/ast/ast.dart';

class PreferImageCacheSizesResult {
  const PreferImageCacheSizesResult({
    required this.astNode,
  });

  final AstNode astNode;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer()..writeln('astNode: ${astNode.toString()}');

    return sb.toString();
  }
}

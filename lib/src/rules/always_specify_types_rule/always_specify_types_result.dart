import 'package:analyzer/dart/ast/ast.dart';

enum ResultType {
  typedLiteral,
  declaredIdentifier,
  setOrMapLiteral,
  simpleFormalParameter,
  typeName,
  variableDeclarationList,
}

class AlwaysSpecifyTypesResult {
  AlwaysSpecifyTypesResult({
    required this.astNode,
    required this.resultType,
  });

  final AstNode astNode;
  final ResultType resultType;

  String get resultTypeAsString => resultType.toString().split('.')[1];

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();

    sb.writeln('resultType: $resultType');
    sb.writeln('astNode: ${astNode.toString()}');

    return sb.toString();
  }
}

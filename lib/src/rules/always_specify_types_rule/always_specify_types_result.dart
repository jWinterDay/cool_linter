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
}

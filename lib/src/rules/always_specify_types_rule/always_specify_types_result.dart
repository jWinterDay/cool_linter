import 'package:analyzer/dart/ast/ast.dart';

enum ResultType {
  typedLiteral,
  declaredIdentifier,
  setOrMapLiteral,
  simpleFormalParameter,
  typeName,
  variableDeclarationList,
}

// TODO remake to util converting from camel case to snake case
const Map<ResultType, String> kOptionNameOfResultType = <ResultType, String>{
  ResultType.typedLiteral: 'typed_literal',
  ResultType.declaredIdentifier: 'declared_identifier',
  ResultType.setOrMapLiteral: 'set_or_map_literal',
  ResultType.simpleFormalParameter: 'simple_formal_parameter',
  ResultType.typeName: 'type_name',
  ResultType.variableDeclarationList: 'variable_declaration_list',
};

class AlwaysSpecifyTypesResult {
  AlwaysSpecifyTypesResult({
    required this.astNode,
    required this.resultType,
  });

  final AstNode astNode;
  final ResultType resultType;

  String get resultTypeAsString => kOptionNameOfResultType[resultType] ?? 'Unknown';

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();

    sb.writeln('resultType: $resultType');
    sb.writeln('astNode: ${astNode.toString()}');

    return sb.toString();
  }
}

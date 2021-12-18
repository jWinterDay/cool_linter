import 'package:analyzer/dart/ast/ast.dart';
import 'package:cool_linter/src/rules/ast_analyze_result.dart';

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

class AlwaysSpecifyTypesResult extends AstAnalyzeResult {
  AlwaysSpecifyTypesResult({
    required AstNode astNode,
    this.correction,
  }) : super(astNode: astNode);

  AlwaysSpecifyTypesResult.withType({
    required AstNode astNode,
    required ResultType type,
    this.correction,
  }) : super(astNode: astNode) {
    resultType = type;
  }

  final String? correction;

  late ResultType resultType;

  String get resultTypeAsString =>
      kOptionNameOfResultType[resultType] ?? 'Unknown';

  @override
  String toString() {
    final StringBuffer sb = StringBuffer()
      ..writeln('resultType: $resultType')
      ..writeln('astNode: ${astNode.toString()}')
      ..writeln('correction: $correction');

    return sb.toString();
  }
}

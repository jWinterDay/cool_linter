import 'package:analyzer/dart/analysis/results.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_result.dart';
import 'package:cool_linter/src/rules/ast_analyze_result_extension.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';

import 'always_specify_types_visitor.dart';

class AlwaysSpecifyTypesRule extends LintRule implements NodeLintRule, Rule {
  AlwaysSpecifyTypesRule()
      : super(
          name: 'cl_always_specify_types',
          description: 'Specify type annotations.',
          details: 'https://flutter.dev/style-guide',
          group: Group.style,
        );

  @override
  final RegExp regExpSuppression = RegExp(r'\/\/(\s)?ignore:(\s)?always_specify_types');

  @override
  List<String> get incompatibleRules {
    return const <String>[
      'avoid_types_on_closure_parameters',
      'omit_local_variable_types',
    ];
  }

  /// custom check
  @override
  List<RuleMessage> check({
    required ResolvedUnitResult parseResult,
    required AnalysisSettings analysisSettings,
  }) {
    final String? path = parseResult.path;
    if (path == null) {
      return <RuleMessage>[];
    }
    // content
    if (parseResult.content == null) {
      return <RuleMessage>[];
    }
    final Iterable<int>? ignoreColumnList = AnalysisSettingsUtil.ignoreColumnList(parseResult, regExpSuppression);
    if (ignoreColumnList == null) {
      return <RuleMessage>[];
    }

    //
    final List<String> types = analysisSettings.alwaysSpecifyTypes;

    final bool useTypedLiteral = types.contains(kOptionNameOfResultType[ResultType.typedLiteral]);
    final bool useDeclaredIdentifier = types.contains(kOptionNameOfResultType[ResultType.declaredIdentifier]);
    final bool useSetOrMapLiteral = types.contains(kOptionNameOfResultType[ResultType.setOrMapLiteral]);
    final bool useSimpleFormalParameter = types.contains(kOptionNameOfResultType[ResultType.simpleFormalParameter]);
    final bool useTypeName = types.contains(kOptionNameOfResultType[ResultType.typeName]);
    final bool useVariableDeclarationList = types.contains(kOptionNameOfResultType[ResultType.variableDeclarationList]);

    // print(
    //   'useTypedLiteral: $useTypedLiteral, useDeclaredIdentifier: $useDeclaredIdentifier, useSetOrMapLiteral: $useSetOrMapLiteral',
    // );
    // print(
    //   'useSimpleFormalParameter: $useSimpleFormalParameter, useTypeName: $useTypeName, useVariableDeclarationList: $useVariableDeclarationList',
    // );

    final AlwaysSpecifyTypesVisitor visitor = AlwaysSpecifyTypesVisitor(
      this,
      useTypedLiteral: useTypedLiteral,
      useDeclaredIdentifier: useDeclaredIdentifier,
      useSetOrMapLiteral: useSetOrMapLiteral,
      useSimpleFormalParameter: useSimpleFormalParameter,
      useTypeName: useTypeName,
      useVariableDeclarationList: useVariableDeclarationList,
    );
    parseResult.unit?.visitChildren(visitor);

    // final List<String> analysisTypes = analysisSettings.coolLinter?.types ?? <String>[];

    return visitor.visitorRuleMessages
        // .where((AlwaysSpecifyTypesResult typesResult) {
        //   return analysisTypes.contains(typesResult.resultTypeAsString);
        // })
        .where((AlwaysSpecifyTypesResult visitorMessage) {
      return visitorMessage.filterByIgnore(
        ignoreColumnList: ignoreColumnList,
        parseResult: parseResult,
        visitorMessage: visitorMessage,
      );
    }).map((AlwaysSpecifyTypesResult typesResult) {
      final int offset = typesResult.astNode.offset;
      final int end = typesResult.astNode.end;

      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      // ignore: always_specify_types
      final endLocation = parseResult.lineInfo.getLocation(end);

      return RuleMessage(
        severityName: 'WARNING',
        message: 'always_specify_rule: ${typesResult.resultTypeAsString}',
        code: typesResult.resultTypeAsString,
        addInfo: typesResult.resultTypeAsString,
        correction: typesResult.correction,
        location: Location(
          parseResult.path!, // file
          offset, // offset
          end - offset, // length
          offsetLocation.lineNumber, // startLine
          offsetLocation.columnNumber, // startColumn
          endLocation.lineNumber, // endLine
          endLocation.columnNumber, // endColumn
        ),
      );
    }).toList();
  }
}

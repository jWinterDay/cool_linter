import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_result.dart';

import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

import 'prefer_trailing_comma_visitor.dart';

class PreferTrailingCommaRule extends LintRule implements NodeLintRule, Rule {
  PreferTrailingCommaRule()
      : super(
          name: 'prefer_trailing_comma',
          description: 'cool_linter prefer trailing comma',
          details: 'my version of https://github.com/dart-code-checker',
          group: Group.style,
        );

  // @override
  // List<String> get incompatibleRules {
  //   return const <String>[
  //     'avoid_types_on_closure_parameters',
  //     'omit_local_variable_types',
  //   ];
  // }

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

    final PreferTrailingCommaVisitor visitor = PreferTrailingCommaVisitor(this);
    parseResult.unit?.visitChildren(visitor);

    // final List<String> analysisTypes = analysisSettings.coolLinter?.types ?? <String>[];

    return visitor.visitorRuleMessages.map((typesResult) {
      final int offset = typesResult.astNode.offset;
      final int end = typesResult.astNode.end;

      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      // ignore: always_specify_types
      final endLocation = parseResult.lineInfo.getLocation(end);

      return RuleMessage(
        severityName: 'WARNING',
        message: 'prefer_trailing_comma',
        code: 'prefer_trailing_comma',
        changeMessage: 'prefer_trailing_comma',
        // addInfo: typesResult.resultTypeAsString,
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

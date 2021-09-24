import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/token.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/ast_analyze_result_extension.dart';
import 'package:cool_linter/src/rules/prefer_trailing_comma/prefer_trailing_comma_result.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';

import 'prefer_trailing_comma_visitor.dart';

class PreferTrailingCommaRule extends LintRule implements NodeLintRule, Rule {
  PreferTrailingCommaRule()
      : super(
          name: 'prefer_trailing_comma',
          description: 'cool_linter prefer trailing comma',
          details: 'cool_linter prefer trailing comma',
          group: Group.style,
        );

  @override
  final RegExp regExpSuppression = RegExp(r'\/\/(\s)?ignore:(\s)?prefer_trailing_comma');

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

    final Iterable<int>? ignoreColumnList = AnalysisSettingsUtil.ignoreColumnList(parseResult, regExpSuppression);
    if (ignoreColumnList == null) {
      return <RuleMessage>[];
    }

    final PreferTrailingCommaVisitor visitor = PreferTrailingCommaVisitor(
      this,
      lineInfo: parseResult.lineInfo,
    );
    parseResult.unit?.visitChildren(visitor);

    return visitor.visitorRuleMessages.where((PreferTrailingCommaResult visitorMessage) {
      return visitorMessage.filterByIgnore(
        ignoreColumnList: ignoreColumnList,
        parseResult: parseResult,
        visitorMessage: visitorMessage,
      );
    }).map((PreferTrailingCommaResult typesResult) {
      final int offset = typesResult.astNode.offset;
      final int end = typesResult.astNode.end;

      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      // ignore: always_specify_types
      final endLocation = parseResult.lineInfo.getLocation(end);

      String? corr = parseResult.content?.substring(offset, end);
      if (corr != null) {
        corr += TokenType.COMMA.lexeme;
      }

      return RuleMessage(
        severityName: 'WARNING',
        message: 'prefer_trailing_comma',
        code: 'prefer_trailing_comma',
        changeMessage: 'prefer_trailing_comma',
        location: Location(
          parseResult.path!, // file
          offset, // offset
          end - offset, // length
          offsetLocation.lineNumber, // startLine
          offsetLocation.columnNumber, // startColumn
          endLocation.lineNumber, // endLine
          endLocation.columnNumber, // endColumn
        ),
        correction: corr,
      );
    }).toList();
  }
}

import 'package:analyzer/dart/analysis/results.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/ast_analyze_result_extension.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';

import 'stream_subscription_result.dart';
import 'stream_subscription_visitor.dart';

class StreamSubscriptionRule extends LintRule implements NodeLintRule, Rule {
  StreamSubscriptionRule()
      : super(
          name: 'always_specify_stream_subscription',
          description: 'always specify stream subscription',
          details: 'https://github.com/jWinterDay/cool_linter',
          group: Group.style,
        );

  @override
  final RegExp regExpSuppression = RegExp(r'\/\/(\s)?ignore:(\s)?always_specify_stream_subscription');

  /// custom check
  @override
  List<RuleMessage> check({
    required ResolvedUnitResult parseResult,
    required AnalysisSettings analysisSettings,
  }) {
    // path
    final String? path = parseResult.path;
    if (path == null) {
      return <RuleMessage>[];
    }

    final Iterable<int>? ignoreColumnList = AnalysisSettingsUtil.ignoreColumnList(parseResult, regExpSuppression);
    if (ignoreColumnList == null) {
      return <RuleMessage>[];
    }

    final StreamSubscriptionVisitor visitor = StreamSubscriptionVisitor(this);
    parseResult.unit?.visitChildren(visitor);

    return visitor.visitorRuleMessages.where((StreamSubscriptionResult visitorMessage) {
      return visitorMessage.filterByIgnore(
        ignoreColumnList: ignoreColumnList,
        parseResult: parseResult,
        visitorMessage: visitorMessage,
      );
    }).map((StreamSubscriptionResult visitorMessage) {
      final int offset = visitorMessage.astNode.offset;
      final int end = visitorMessage.astNode.end;

      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      // ignore: always_specify_types
      final endLocation = parseResult.lineInfo.getLocation(end);

      return RuleMessage(
        severityName: 'WARNING', // always_specify_stream_subscription
        message: 'always_specify_stream_subscription',
        code: 'always_specify_stream_subscription', // visitorMessage.resultTypeAsString,
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

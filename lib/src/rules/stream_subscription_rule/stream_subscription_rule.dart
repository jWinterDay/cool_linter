import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_result.dart';

import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

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

    final StreamSubscription<void> sub1 = Stream<void>.periodic(const Duration(seconds: 1), (_) {}).listen((_) {
      // do nothing
    });
    sub1.cancel();

    final StreamSubscriptionVisitor visitor = StreamSubscriptionVisitor(this);
    parseResult.unit?.visitChildren(visitor);

    // final List<String> analysisTypes = analysisSettings.coolLinter?.types ?? <String>[];

    return visitor.visitorRuleMessages.map((StreamSubscriptionResult visitorMessage) {
      final int offset = visitorMessage.astNode.offset;
      final int end = visitorMessage.astNode.end;

      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      // ignore: always_specify_types
      final endLocation = parseResult.lineInfo.getLocation(end);

      return RuleMessage(
        severityName: 'WARNING', // always_specify_stream_subscription
        message: 'cool_linter. always specify stream subscription',
        code: 'always_specify_stream_subscription', // visitorMessage.resultTypeAsString,
        changeMessage: 'cool_linter. always_specify_stream_subscription',
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

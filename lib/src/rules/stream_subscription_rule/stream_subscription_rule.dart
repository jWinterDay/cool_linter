import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;

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
    // content
    if (parseResult.content == null) {
      return <RuleMessage>[];
    }
    final String content = parseResult.content!;

    final Iterable<RegExpMatch> matches = regExpSuppression.allMatches(content);

    // places of [// ignore: always_specify_stream_subscription] comment
    final Iterable<int> ignoreColumnList = matches.map((RegExpMatch match) {
      // ignore: always_specify_types
      final loc = parseResult.lineInfo.getLocation(match.start);

      return loc.lineNumber;
    });

    final StreamSubscriptionVisitor visitor = StreamSubscriptionVisitor(this);
    parseResult.unit?.visitChildren(visitor);

    return visitor.visitorRuleMessages.where((StreamSubscriptionResult visitorMessage) {
      final int offset = visitorMessage.astNode.offset;
      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      final int warningLineNumber = offsetLocation.lineNumber;

      final bool willIgnoreNextLine = ignoreColumnList.any((int ignoreLineNumber) {
        return ignoreLineNumber + 1 == warningLineNumber;
      });

      return !willIgnoreNextLine;
    }).map((StreamSubscriptionResult visitorMessage) {
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

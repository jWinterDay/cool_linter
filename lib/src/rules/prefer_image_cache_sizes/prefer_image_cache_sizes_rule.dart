import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;

import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

import 'prefer_image_cache_sizes_result.dart';
import 'prefer_image_cache_sizes_visitor.dart';

class PreferImageCacheSizesRule extends LintRule implements NodeLintRule, Rule {
  PreferImageCacheSizesRule()
      : super(
          name: 'prefer_image_cache_sizes',
          description: 'cool_linter. prefer image cacheWidth and cacheHeight',
          details: 'https://flutter.dev/style-guide',
          group: Group.style,
        );

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

    final PreferImageCacheSizesVisitor visitor = PreferImageCacheSizesVisitor(this);
    parseResult.unit?.visitChildren(visitor);

    // final List<String> analysisTypes = analysisSettings.coolLinter?.types ?? <String>[];

    return visitor.visitorRuleMessages
        // .where((AlwaysSpecifyTypesResult typesResult) {
        //   return analysisTypes.contains(typesResult.resultTypeAsString);
        // })
        .map((PreferImageCacheSizesResult resultMessage) {
      final int offset = resultMessage.astNode.offset;
      final int end = resultMessage.astNode.end;

      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      // ignore: always_specify_types
      final endLocation = parseResult.lineInfo.getLocation(end);

      return RuleMessage(
        severityName: 'WARNING',
        message: 'cool_linter. prefer image cacheWidth and cacheHeight',
        code: 'prefer_image_cache_sizes',
        changeMessage: 'cool_linter. use image cacheWidth and cacheHeight',
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

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_result.dart';

import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

import 'always_specify_types_visitor.dart';

class AlwaysSpecifyTypesRule extends LintRule implements NodeLintRule, Rule {
  AlwaysSpecifyTypesRule()
      : super(
          name: 'cool_linter_always_specify_types',
          description: 'cool_linter specify type annotations.',
          details: 'https://flutter.dev/style-guide',
          group: Group.style,
        );

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
    required YamlConfig yamlConfig,
  }) {
    final String? path = parseResult.path;
    if (path == null) {
      return <RuleMessage>[];
    }

    final AlwaysSpecifyTypesVisitor visitor = AlwaysSpecifyTypesVisitor(this);
    parseResult.unit?.visitChildren(visitor);

    return visitor.visitorRuleMessages.map((AlwaysSpecifyTypesResult result) {
      final int offset = result.astNode.offset;
      final int end = result.astNode.end;

      // ignore: always_specify_types
      final offsetLocation = parseResult.lineInfo.getLocation(offset);
      // ignore: always_specify_types
      final endLocation = parseResult.lineInfo.getLocation(end);

      return RuleMessage(
        message: 'cool_linter. always specify type: $result',
        code: 'cool_linter_needs_fixes',
        changeMessage: 'cool_linter. always_specify_type for type: $result',
        addInfo: result.resultTypeAsString,
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

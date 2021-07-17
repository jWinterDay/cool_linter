import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;

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

    return <RuleMessage>[];
  }
}

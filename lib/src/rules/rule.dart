import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, LinterContext, NodeLintRegistry, NodeLintRule;

abstract class Rule extends LintRule {
  Rule()
      : super(
          name: 'cl_always_specify_types',
          description: 'Specify type annotations.',
          details: 'https://flutter.dev/style-guide',
          group: Group.style,
        );

  // Rule() : super();

  List<RuleMessage> check({
    required ResolvedUnitResult parseResult,
    required YamlConfig yamlConfig,
  });
}

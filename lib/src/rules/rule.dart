import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

abstract class Rule {
  List<RuleMessage> check({
    required ResolvedUnitResult parseResult,
    required YamlConfig yamlConfig,
  });
}

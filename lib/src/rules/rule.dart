import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

abstract class Rule {
  List<RuleMessage> check({
    required String content,
    required String path,
    required YamlConfig yamlConfig,
  });
}

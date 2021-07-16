import 'dart:convert';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/rules/regexp_rule/regexp_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../utils/mock_resolve_unit_result.dart';
import '../utils/resolved_unit_util.dart';

const String _kTestDataPath = 'test/regexp/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  setUp(() async {
    resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
  });

  group('regexp find lines by patterns', () {
    final Rule regExpRule = RegExpRule();

    final YamlConfig yamlConfig = YamlConfig.fromJson(
      json.encode(
        loadYaml(r'''
            cool_linter:
              exclude_words:
                -
                  pattern: TestClass
                  hint: Correct test class name pattern
                  severity: WARNING
            '''),
      ),
    );

    test('regexp_rule find 4 Colors', () async {
      final List<RuleMessage> list = regExpRule.check(
        parseResult: resolvedUnitResult,
        yamlConfig: yamlConfig,
      );

      expect(list, hasLength(1));
    });
  });
}

import 'dart:convert';

import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/rules/regexp_rule/regexp_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../utils/mock_resolve_unit_result.dart';

void main() {
  group('regexp find lines by patterns', () {
    final Rule regExpRule = RegExpRule();

    final YamlConfig yamlConfig = YamlConfig.fromJson(
      json.encode(
        loadYaml(r'''
            cool_linter:
              exclude_words:
                -
                  pattern: Color
                  hint: Correct RegExp pattern
                  severity: WARNING
            '''),
      ),
    );

    test('regexp_rule find 4 Colors', () async {
      const String twoColorsString = r'''
        import 'package:flutter/material.dart';

        class B {
          void test() {
            final t = Colors.accents;
            final t2 = Colors.white;
            final t2 = Color(0xFF123456);
            final t3 = Color.fromARGB(1, 2, 3, 4);
          }
        }
        ''';

      final List<RuleMessage> list = regExpRule.check(
        content: twoColorsString,
        parseResult: MockResolvedUnitResult(),
        yamlConfig: yamlConfig,
      );

      expect(list, hasLength(4));
    });
  });
}

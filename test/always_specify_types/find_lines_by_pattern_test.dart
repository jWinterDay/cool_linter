import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart';

import '../utils/resolved_unit_util.dart';

const String _kTestDataPath = 'test/always_specify_types/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  group('regexp find lines by patterns', () {
    setUp(() async {
      resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
    });

    final Rule specifyTypesRule = AlwaysSpecifyTypesRule();
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

    test('specify types', () async {
      final List<RuleMessage> list = specifyTypesRule.check(
        parseResult: resolvedUnitResult,
        yamlConfig: yamlConfig,
      );

      expect(list, hasLength(0));
    });
  });
}

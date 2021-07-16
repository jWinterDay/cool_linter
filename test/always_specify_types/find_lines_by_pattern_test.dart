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

const String _kExamplePath = 'test/always_specify_types/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  group('regexp find lines by patterns', () {
    setUp(() async {
      final File file = File(_kExamplePath);
      if (!file.existsSync()) {
        throw ArgumentError(
          'Unable to find a file for the given path: $_kExamplePath',
        );
      }

      final String filePath = normalize(file.absolute.path);
      final SomeResolvedUnitResult parseResult = await resolveFile2(path: filePath);
      if (parseResult is! ResolvedUnitResult) {
        throw ArgumentError(
          'Unable to correctly resolve file for given path: $_kExamplePath',
        );
      }

      resolvedUnitResult = parseResult;
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
      const String testClass = r'''
        class B {
          final _a = 2;

          void test() {
            final t = 1;
            final t2 = 'test';
            final t3 = [1,2,3];
            final List<int> t4 = [1,2,3];
            final List<int> noWarnings = <int>[1,2,3];
          }
        }
        ''';

      final List<RuleMessage> list = specifyTypesRule.check(
        content: testClass,
        parseResult: resolvedUnitResult,
        yamlConfig: yamlConfig,
      );

      expect(list, hasLength(0));
    });
  });
}

import 'dart:convert';

import 'package:cool_linter/src/checker.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('find lines by patterns', () {
    const Checker checker = Checker();

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

    test('find 4 Colors', () async {
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

      final List<IncorrectLineInfo>? list = checker.getIncorrectLines(twoColorsString, yamlConfig);

      expect(list, isNotNull);
      expect(list?.length, 4);
    });
  });
}

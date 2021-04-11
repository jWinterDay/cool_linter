// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Analysis_options.yaml', () {
    test('parse yaml', () {
      const String _exampleYaml = '''
analyzer:
  plugins:
    - cool_linter

  strong-mode:
    implicit-casts: false
    implicit-dynamic: false

cool_linter:
  exclude_words:
    -
      pattern: Colors
      hint: Use colors from design system instead!
      severity: WARNING
    -
      pattern: Test
      hint: Use Test1 instead!
      severity: ERROR
  exclude_folders:
    - test/**

linter:
  rules:
    - always_put_control_body_on_new_line
    - always_put_required_named_parameters_first
''';

      final String rawYaml = json.encode(loadYaml(_exampleYaml));
      final YamlConfig yamlConfig = YamlConfig.fromJson(rawYaml);

      expect(yamlConfig.coolLinter!.excludeFolders, <String>['test/**']);

      // Colors
      expect(yamlConfig.coolLinter!.excludeWords!.length, 2);
      expect(yamlConfig.coolLinter!.excludeWords![0].pattern, 'Colors');
      expect(yamlConfig.coolLinter!.excludeWords![0].hint, 'Use colors from design system instead!');
      expect(yamlConfig.coolLinter!.excludeWords![0].severity, 'WARNING');

      // Test
      expect(yamlConfig.coolLinter!.excludeWords![1].pattern, 'Test');
      expect(yamlConfig.coolLinter!.excludeWords![1].hint, 'Use Test1 instead!');
      expect(yamlConfig.coolLinter!.excludeWords![1].severity, 'ERROR');
    });

    test('pattern as correct RegExp', () {
      const String _yamlWithCorrectWordRegExp = '''
cool_linter:
  exclude_words:
    -
      pattern: ^Test{1}
      hint: Correct RegExp pattern
      severity: WARNING
''';

      final String rawYaml = json.encode(loadYaml(_yamlWithCorrectWordRegExp));
      final YamlConfig yamlConfig = YamlConfig.fromJson(rawYaml);

      final String rawRegExpStr = yamlConfig.coolLinter!.excludeWords![0].pattern!;
      expect(rawRegExpStr, '^Test{1}');

      // try to find text
      final RegExp regExp = RegExp(rawRegExpStr);
      const String exampleStr = '''Test t''';
      final int index = exampleStr.indexOf(regExp);
      expect(index, greaterThan(-1));
    });

    test('pattern as incorrect RegExp', () {
      const String _yamlWithIncorrectWordRegExp = '''
cool_linter:
  exclude_words:
    -
      pattern: Test{a}
      hint: Correct RegExp pattern
      severity: WARNING
''';

      final String rawYaml = json.encode(loadYaml(_yamlWithIncorrectWordRegExp));
      final YamlConfig yamlConfig = YamlConfig.fromJson(rawYaml);

      final String rawRegExpStr = yamlConfig.coolLinter!.excludeWords![0].pattern!;
      expect(rawRegExpStr, 'Test{a}');

      // try to create RegExp
      final RegExp regExp = RegExp(rawRegExpStr);

      // regExp.print('regExp = $regExp');
      const String exampleStr = '''Test t''';
      final int index = exampleStr.indexOf(regExp);
      expect(index, -1);
    });

    test('no pattern', () {
      const String _yamlWithNoPattern = '''
cool_linter:
  exclude_words:
    -
      hint: Correct RegExp pattern
      severity: WARNING
''';

      final String rawYaml = json.encode(loadYaml(_yamlWithNoPattern));
      final YamlConfig yamlConfig = YamlConfig.fromJson(rawYaml);
      final String? rawRegExpStr = yamlConfig.coolLinter!.excludeWords![0].pattern;

      expect(rawRegExpStr, isNull);
    });
  });
}

import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('AnalysisSettings.dart', () {
    test('parse full yaml', () {
      const String yaml = '''
        cool_linter:
          always_specify_types:
            - typed_literal
            - declared_identifier
            - set_or_map_literal
            - simple_formal_parameter
            - type_name
            - variable_declaration_list
          regexp_exclude:
            -
              pattern: Colors
              hint: Hint
              severity: WARNING
          exclude_folders:
            - test/**
        ''';

      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(AnalysisSettingsUtil.convertYamlToMap(yaml));

      expect(analysisSettings.coolLinter?.types, hasLength(6));
      expect(analysisSettings.coolLinter?.regexpExclude, hasLength(1));
      expect(analysisSettings.coolLinter?.excludeFolders, hasLength(1));

      expect(analysisSettings.coolLinter?.regexpExclude.first.pattern, 'Colors');
      expect(analysisSettings.coolLinter?.regexpExclude.first.hint, 'Hint');
      expect(analysisSettings.coolLinter?.regexpExclude.first.severity, 'WARNING');
    });

    test('no cool_linter settings', () {
      const String yaml = '''
      linter:
        rules:
          always_declare_return_types: true
        ''';

      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(AnalysisSettingsUtil.convertYamlToMap(yaml));

      expect(analysisSettings.coolLinter, isNull);
    });

    test('parse only regexp exclude', () {
      const String yaml = '''
        cool_linter:
          regexp_exclude:
            -
              pattern: Colors
              hint: Hint
              severity: WARNING
        ''';

      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(AnalysisSettingsUtil.convertYamlToMap(yaml));

      expect(analysisSettings.coolLinter?.types, hasLength(0));
      expect(analysisSettings.coolLinter?.regexpExclude, hasLength(1));
      expect(analysisSettings.coolLinter?.excludeFolders, hasLength(0));
    });

    test('parse only always specify types', () {
      const String yaml = '''
        cool_linter:
          always_specify_types:
            - typed_literal
        ''';

      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(AnalysisSettingsUtil.convertYamlToMap(yaml));

      expect(analysisSettings.coolLinter?.types, hasLength(1));
      expect(analysisSettings.coolLinter?.regexpExclude, hasLength(0));
      expect(analysisSettings.coolLinter?.excludeFolders, hasLength(0));
    });

    test('parse only exclude folders', () {
      const String yaml = '''
        cool_linter:
          exclude_folders:
            - test/**
            - test2/**
        ''';

      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(AnalysisSettingsUtil.convertYamlToMap(yaml));

      expect(analysisSettings.coolLinter?.types, hasLength(0));
      expect(analysisSettings.coolLinter?.regexpExclude, hasLength(0));
      expect(analysisSettings.coolLinter?.excludeFolders, hasLength(2));
    });
  });
}

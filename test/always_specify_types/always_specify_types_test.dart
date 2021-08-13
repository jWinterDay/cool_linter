import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_result.dart';
import 'package:cool_linter/src/rules/always_specify_types_rule/always_specify_types_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:test/test.dart';

import '../utils/resolved_unit_util.dart';

const String _kTestDataPath = 'test/always_specify_types/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  group('regexp find lines by patterns', () {
    setUp(() async {
      resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
    });

    final Rule specifyTypesRule = AlwaysSpecifyTypesRule();

    test('specify types', () async {
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          r'''
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
                pattern: Color
                hint: Correct RegExp pattern
                severity: WARNING
        ''',
        ),
      );

      final List<RuleMessage> list = specifyTypesRule.check(
        parseResult: resolvedUnitResult,
        analysisSettings: analysisSettings,
      );

      // typedLiteral
      final Iterable<RuleMessage> typedLiteralList = list.where((RuleMessage e) {
        return e.code == kOptionNameOfResultType[ResultType.typedLiteral];
      });
      expect(typedLiteralList, hasLength(3));

      // typeName
      final Iterable<RuleMessage> typeNameList = list.where((RuleMessage e) {
        return e.code == kOptionNameOfResultType[ResultType.typeName];
      });
      expect(typeNameList, hasLength(4));

      // variableDeclarationList
      final Iterable<RuleMessage> varDecList = list.where((RuleMessage e) {
        return e.code == kOptionNameOfResultType[ResultType.variableDeclarationList];
      });
      expect(varDecList, hasLength(10));

      // simpleFormalParameter
      final Iterable<RuleMessage> simpleFParList = list.where((RuleMessage e) {
        return e.code == kOptionNameOfResultType[ResultType.simpleFormalParameter];
      });
      expect(simpleFParList, hasLength(5));

      expect(list, hasLength(24));
    });
  });
}

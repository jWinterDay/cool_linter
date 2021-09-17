import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/prefer_trailing_comma/prefer_trailing_comma_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:test/test.dart';

import '../utils/resolved_unit_util.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  final Rule preferTrailingCommaRule = PreferTrailingCommaRule();

  group('default prefer_trailing_comma', () {
    const String _kTestDataPath = 'test/prefer_trailing_comma/test_data.dart';

    setUp(() async {
      resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
    });

    test('prefer_trailing_comma rule', () async {
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          r'''
          cool_linter:
            extended_rules:
              - prefer_trailing_comma
        ''',
        ),
      );

      // yaml
      expect(analysisSettings.usePreferTrailingComma, isTrue);

      // checker
      final List<RuleMessage> ruleMessageList = preferTrailingCommaRule.check(
        parseResult: resolvedUnitResult,
        analysisSettings: analysisSettings,
      );

      expect(ruleMessageList, hasLength(7));

      // ruleMessageList.map((RuleMessage e) {
      //   return '${e.location.startLine}';
      // }).forEach((String element) {
      //   print('>> $element');
      // });
    });
  });

  // group('extended prefer_trailing_comma', () {
  //   const String _kTestDataPath = 'test/prefer_trailing_comma/test_data_extended.dart';

  //   setUp(() async {
  //     resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
  //   });

  //   test('prefer_trailing_comma rule', () async {
  //     final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
  //       AnalysisSettingsUtil.convertYamlToMap(
  //         r'''
  //         cool_linter:
  //           prefer_trailing_comma:
  //             break-on: 2
  //       ''',
  //       ),
  //     );

  //     // yaml
  //     expect(analysisSettings.coolLinter!.preferTrailingComma?.breakOn, 2);

  //     // checker
  //     final List<RuleMessage> ruleMessageList = preferTrailingCommaRule.check(
  //       parseResult: resolvedUnitResult,
  //       analysisSettings: analysisSettings,
  //     );

  //     // expect(ruleMessageList, hasLength(12));

  //     // ruleMessageList.map((e) => '${e.location.startLine}').forEach((element) {
  //     //   print('>> $element');
  //     // });
  //   });
  // });
}

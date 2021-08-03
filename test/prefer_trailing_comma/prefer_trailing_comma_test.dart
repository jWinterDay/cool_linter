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
      // TODO
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          r'''
          cool_linter:
            extended_rules:
              - always_specify_stream_subscription
        ''',
        ),
      );

      // yaml
      // TODO
      // expect(analysisSettings.coolLinter!.extendedRules, hasLength(1));
      // expect(analysisSettings.coolLinter!.extendedRules.first, 'always_specify_stream_subscription');

      // checker
      final List<RuleMessage> ruleMessageList = preferTrailingCommaRule.check(
        parseResult: resolvedUnitResult,
        analysisSettings: analysisSettings,
      );

      // expect(ruleMessageList, hasLength(5));

      // ruleMessageList.map((e) => '${e.location.startLine}').forEach((element) {
      //   print('>> $element');
      // });
    });
  });

  group('extended prefer_trailing_comma', () {
    const String _kTestDataPath = 'test/prefer_trailing_comma/test_data_extended.dart';

    setUp(() async {
      resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
    });

    test('prefer_trailing_comma rule', () async {
      // TODO
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          r'''
          cool_linter:
            extended_rules:
              - always_specify_stream_subscription
        ''',
        ),
      );

      // yaml
      // TODO
      // expect(analysisSettings.coolLinter!.extendedRules, hasLength(1));
      // expect(analysisSettings.coolLinter!.extendedRules.first, 'always_specify_stream_subscription');

      // checker
      final List<RuleMessage> ruleMessageList = preferTrailingCommaRule.check(
        parseResult: resolvedUnitResult,
        analysisSettings: analysisSettings,
      );

      // expect(ruleMessageList, hasLength(5));

      ruleMessageList.map((e) => '${e.location.startLine}').forEach((element) {
        print('>> $element');
      });
    });
  });
}

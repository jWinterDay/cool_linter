import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/prefer_image_cache_sizes/prefer_image_cache_sizes_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/rules/stream_subscription_rule/stream_subscription_rule.dart';
import 'package:cool_linter/src/utils/utils.dart';
import 'package:test/test.dart';

import '../utils/resolved_unit_util.dart';

const String _kTestDataPath = 'test/prefer_image_cache_sizes/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  group('prefer image cache sizes', () {
    setUp(() async {
      resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
    });

    final Rule preferImageCacheSizesRule = PreferImageCacheSizesRule();

    test('rule', () async {
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          r'''
          cool_linter:
            extended_rules:
              - always_specify_stream_subscription
              - prefer_image_cache_sizes
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

      // yaml
      expect(analysisSettings.coolLinter!.extendedRules, hasLength(2));

      final bool existsRule = analysisSettings.coolLinter!.extendedRules.contains('prefer_image_cache_sizes');
      expect(existsRule, isTrue);

      // // checker
      // final List<RuleMessage> ruleMessageList = specifyStreamSubscriptionRule.check(
      //   parseResult: resolvedUnitResult,
      //   analysisSettings: analysisSettings,
      // );

      // expect(ruleMessageList, hasLength(5));

      // ruleMessageList.map((e) => '${e.location.startLine}').forEach((element) {
      //   print('>> $element');
      // });
    });
  });
}

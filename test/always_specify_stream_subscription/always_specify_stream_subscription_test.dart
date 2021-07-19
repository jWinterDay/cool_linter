import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/rules/stream_subscription_rule/stream_subscription_rule.dart';
import 'package:cool_linter/src/utils/utils.dart';
import 'package:test/test.dart';

import '../utils/resolved_unit_util.dart';

const String _kTestDataPath = 'test/always_specify_stream_subscription/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  group('specify stream subscription', () {
    setUp(() async {
      resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
    });

    final Rule specifyStreamSubscriptionRule = StreamSubscriptionRule();

    test('specify stream subscription rule', () async {
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          r'''
          cool_linter:
            extended_rules:
              - always_specify_stream_subscription
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

      expect(analysisSettings.coolLinter!.extendedRules, hasLength(1));
      expect(analysisSettings.coolLinter!.extendedRules.first, 'always_specify_stream_subscription');

      final List<RuleMessage> ruleMessageList = specifyStreamSubscriptionRule.check(
        parseResult: resolvedUnitResult,
        analysisSettings: analysisSettings,
      );

      print('ruleMessageList = $ruleMessageList');
    });
  });
}

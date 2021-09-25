import 'package:analyzer/dart/analysis/results.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/regexp_rule/regexp_rule.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:test/test.dart';

import '../../lib/src/utils/resolved_unit_util.dart';

const String _kTestDataPath = 'test/regexp/test_data.dart';

void main() {
  late ResolvedUnitResult resolvedUnitResult;

  setUp(() async {
    resolvedUnitResult = await getResolvedUnitResult(_kTestDataPath);
  });

  group('regexp find lines by patterns', () {
    final Rule regExpRule = RegExpRule();

    test('regexp_rule find one regexp rule', () async {
      final AnalysisSettings analysisSettings = AnalysisSettings.fromJson(
        AnalysisSettingsUtil.convertYamlToMap(
          '''
          cool_linter:
            regexp_exclude:
              -
                pattern: \\sTestClass2
                hint: Correct test class name pattern
                severity: WARNING
              -
                pattern: \\sTestClass\\s
                hint: hint 2
                severity: ERROR
          ''',
        ),
      );

      final List<RuleMessage> list = regExpRule.check(
        parseResult: resolvedUnitResult,
        analysisSettings: analysisSettings,
      );

      expect(list, hasLength(4));

      // list.forEach((RuleMessage mess) {
      //   print('${mess.message} ${mess.location.file}:${mess.location.endLine}:${mess.location.endColumn}');
      // });
    });
  });
}

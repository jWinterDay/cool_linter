import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';
import 'package:cool_linter/src/utils/analyse_utils.dart';
import 'package:glob/glob.dart';

import 'rules/always_specify_types_rule/always_specify_types_rule.dart';
import 'rules/regexp_rule/regexp_rule.dart';
import 'rules/stream_subscription_rule/stream_subscription_rule.dart';

// TODO: add if exists in analysis options
// final List<Rule> kRulesList = <Rule>[
//   RegExpRule(),
//   AlwaysSpecifyTypesRule(),
//   StreamSubscriptionRule(),
// ];

class Checker {
  const Checker();

  Iterable<AnalysisErrorFixes> checkResult({
    required AnalysisSettings analysisSettings,
    required List<Glob> excludesGlobList,
    required ResolvedUnitResult parseResult,
    AnalysisErrorSeverity errorSeverity = AnalysisErrorSeverity.WARNING,
  }) {
    final bool isExcluded =
        AnalysisSettingsUtil.isExcluded(parseResult.path, excludesGlobList);
    if (isExcluded) {
      return <AnalysisErrorFixes>[];
    }

    // rules using
    final List<Rule> kRulesList = <Rule>[
      if (analysisSettings.useRegexpExclude) RegExpRule(),
      if (analysisSettings.useAlwaysSpecifyTypes) AlwaysSpecifyTypesRule(),
      if (analysisSettings.useAlwaysSpecifyStreamSub) StreamSubscriptionRule(),
    ];

    final Iterable<RuleMessage> errorMessageList = kRulesList.map((Rule rule) {
      return rule.check(
        parseResult: parseResult,
        analysisSettings: analysisSettings,
      );
    }).expand((List<RuleMessage> errorMessage) {
      return errorMessage;
    });

    if (errorMessageList.isEmpty) {
      return <AnalysisErrorFixes>[];
    }

    return errorMessageList.map((RuleMessage errorMessage) {
      final AnalysisError error = AnalysisError(
        AnalysisErrorSeverity.INFO, //( errorMessage.severityName),
        AnalysisErrorType.LINT,
        errorMessage.location,
        errorMessage.message,
        errorMessage.code,
        hasFix: true,
        correction:
            'go correct path = ${parseResult.path} offset = ${errorMessage.location.offset} len = ${errorMessage.location.length}',
      );

      final PrioritizedSourceChange fix = PrioritizedSourceChange(
        1,
        SourceChange(
          'Apply fixes for cool_linter.',
          edits: <SourceFileEdit>[
            SourceFileEdit(
              parseResult.path,
              1,
              edits: <SourceEdit>[
                SourceEdit(
                  errorMessage.location.offset, //1,
                  errorMessage.location.length, //2,
                  errorMessage.changeMessage,
                ),
              ],
            )
          ],
        ),
      );

      return AnalysisErrorFixes(
        error,
        fixes: <PrioritizedSourceChange>[
          fix,
        ],
      );
    });
  }
}

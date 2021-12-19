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
    if (parseResult.content == null || parseResult.path == null) {
      return <AnalysisErrorFixes>[];
    }

    final bool isExcluded = AnalysisSettingsUtil.isExcluded(parseResult.path, excludesGlobList);
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
        AnalysisErrorSeverity(errorMessage.severityName),
        AnalysisErrorType.LINT,
        errorMessage.location,
        errorMessage.message,
        errorMessage.code,
        correction: errorMessage.correction,
        hasFix: errorMessage.replacement != null,
      );

      final List<PrioritizedSourceChange>? fixes;
      if (errorMessage.replacement != null) {
        final PrioritizedSourceChange fix = PrioritizedSourceChange(
          1,
          SourceChange(
            'Replace with ${errorMessage.replacement}',
            edits: <SourceFileEdit>[
              SourceFileEdit(
                parseResult.path!,
                parseResult.unit?.declaredElement?.source.modificationStamp ?? 1,
                edits: <SourceEdit>[
                  SourceEdit(
                    errorMessage.location.offset, //1,
                    errorMessage.location.length, //2,
                    errorMessage.replacement ?? '',
                  ),
                ],
              )
            ],
          ),
        );

        fixes = <PrioritizedSourceChange>[fix];
      } else {
        fixes = null;
      }

      return AnalysisErrorFixes(
        error,
        fixes: fixes,
      );
    });
  }
}

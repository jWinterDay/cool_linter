import 'package:analyzer/dart/analysis/results.dart';
// ignore: implementation_imports
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group; //, LinterContext, NodeLintRegistry, NodeLintRule;
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

abstract class Rule extends LintRule {
  Rule()
      : super(
          name: 'cool_linter_rule',
          description: 'cool linter rule',
          details: 'https://flutter.dev/style-guide',
          group: Group.style,
        );

  RegExp get regExpSuppression;

  List<RuleMessage> check({
    required ResolvedUnitResult parseResult,
    required AnalysisSettings analysisSettings,
  });
}

// import 'package:code_checker/rules.dart';
// import 'package:cool_linter/src/rules/exclude_words.dart';

// // ignore: always_specify_types
// final _implementedRules = <String, Rule Function(Map<String, Object>)>{
//   ExcludeWordsRule.kRuleId: (Map<String, Object> config) => ExcludeWordsRule(config: config),
// };

// // Iterable<Rule> get allRules {
// //   // ignore: always_specify_types
// //   return _implementedRules.keys.map((String id) => _implementedRules[id]({}));
// // }

// Iterable<Rule> getRulesById(Map<String, Object> rulesConfig) {
//   return List<Rule>.unmodifiable(_implementedRules.keys.where((String id) {
//     return rulesConfig.keys.contains(id);
//   }).map<Rule>((String id) {
//     // ignore: avoid_as
//     return _implementedRules[id](rulesConfig[id] as Map<String, Object>);
//   }));
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_settings.freezed.dart';
part 'analysis_settings.g.dart';

/// ``` yaml
/// cool_linter:
///   always_specify_types:
///     - typed_literal
///     - declared_identifier
///     - set_or_map_literal
///     - simple_formal_parameter
///     - type_name
///     - variable_declaration_list
///   regexp_exclude:
///     -
///       pattern: Colors
///       hint: Use colors from design system instead!
///       severity: WARNING
///   exclude_folders:
///    - test/**
/// ```
///
/// and map associated with this yaml:
/// ```
/// {
///   cool_linter: {
///     always_specify_types: [typed_literal, declared_identifier, set_or_map_literal, simple_formal_parameter, type_name, variable_declaration_list],
///     regexp_exclude: [{pattern: Colors, hint: Use colors from design system instead!, severity: WARNING}],
///     exclude_folders: [test/**]
///   }
/// }
/// ```
@freezed
class AnalysisSettings with _$AnalysisSettings {
  const AnalysisSettings._();

  const factory AnalysisSettings({
    @Default(CoolLinter()) @JsonKey(name: 'cool_linter') CoolLinter? coolLinter,
  }) = _AnalysisSettings;

  factory AnalysisSettings.fromJson(Map<String, dynamic> json) => _$AnalysisSettingsFromJson(json);
}

@freezed
class CoolLinter with _$CoolLinter {
  const CoolLinter._();

  const factory CoolLinter({
    @Default(<String>[]) @JsonKey(name: 'always_specify_types', defaultValue: <String>[]) List<String> types,
    @Default(<ExcludeWords>[])
    @JsonKey(name: 'regexp_exclude', defaultValue: <ExcludeWords>[])
        List<ExcludeWords> regexpExclude,
    @Default(<String>[]) @JsonKey(name: 'exclude_folders', defaultValue: <String>[]) List<String> excludeFolders,
  }) = _CoolLinter;

  factory CoolLinter.fromJson(Map<String, dynamic> json) => _$CoolLinterFromJson(json);
}

// @freezed
// class AlwaysSpecifyTypes with _$AlwaysSpecifyTypes {
//   const AlwaysSpecifyTypes._();

//   const factory AlwaysSpecifyTypes({
//     @Default(<String>[]) List<String> types,
//   }) = _AlwaysSpecifyTypes;

//   factory AlwaysSpecifyTypes.fromJson(Map<String, dynamic> json) => _$AlwaysSpecifyTypesFromJson(json);
// }

// @freezed
// class RegexpExclude with _$RegexpExclude {
//   const RegexpExclude._();

//   const factory RegexpExclude({
//     @JsonKey(name: 'exclude_words') List<ExcludeWords>? excludeWords,
//   }) = _RegexpExclude;

//   factory RegexpExclude.fromJson(Map<String, dynamic> json) => _$RegexpExcludeFromJson(json);
// }

@freezed
class ExcludeWords with _$ExcludeWords {
  const ExcludeWords._();

  const factory ExcludeWords(
    String pattern, {
    @Default('') String hint,
    @Default('WARNING') String severity,
  }) = _ExcludeWords;

  factory ExcludeWords.fromJson(Map<String, dynamic> json) => _$ExcludeWordsFromJson(json);
}

// @freezed
// class ExcludeFolders with _$ExcludeFolders {
//   const ExcludeFolders._();

//   const factory ExcludeFolders({
//     @Default(<String>[]) List<String> folders,
//   }) = _ExcludeFolders;

//   factory ExcludeFolders.fromJson(Map<String, dynamic> json) => _$ExcludeFoldersFromJson(json);
// }

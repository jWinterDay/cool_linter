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

  /// return null if correct
  // String? get checkCorrectMessage {
  //   // exclude word list
  //   if (coolLinter?. excludeWords == null) {
  //     return 'exclude_words param list cannot be null';
  //   }

  //   if (coolLinter!.excludeWords!.isEmpty) {
  //     return 'exclude_words param list cannot be empty';
  //   }

  //   return null;
  // }
}

@freezed
class CoolLinter with _$CoolLinter {
  const CoolLinter._();

  const factory CoolLinter({
    @Default(<String>[]) @JsonKey(name: 'always_specify_types', defaultValue: <String>[]) List<String> types,
    @Default(<ExcludeWord>[])
    @JsonKey(name: 'regexp_exclude', defaultValue: <ExcludeWord>[])
        List<ExcludeWord> regexpExclude,
    @Default(<String>[]) @JsonKey(name: 'exclude_folders', defaultValue: <String>[]) List<String> excludeFolders,
  }) = _CoolLinter;

  factory CoolLinter.fromJson(Map<String, dynamic> json) => _$CoolLinterFromJson(json);
}

@freezed
class ExcludeWord with _$ExcludeWord {
  const ExcludeWord._();

  const factory ExcludeWord(
    String pattern, {
    @Default('') String hint,
    @Default('WARNING') String severity,
  }) = _ExcludeWord;

  factory ExcludeWord.fromJson(Map<String, dynamic> json) => _$ExcludeWordFromJson(json);
}

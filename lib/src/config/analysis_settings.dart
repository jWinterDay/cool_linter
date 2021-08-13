import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_settings.freezed.dart';
part 'analysis_settings.g.dart';

/// ``` yaml
/// cool_linter:
///   extended_rules:
///     - always_specify_stream_subscription
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
///   prefer_trailing_comma:
///     - break-ok: 2
///   exclude_folders:
///    - test/**
/// ```
///
@freezed
class AnalysisSettings with _$AnalysisSettings {
  const AnalysisSettings._();

  const factory AnalysisSettings({
    @Default(CoolLinter()) @JsonKey(name: 'cool_linter') CoolLinter? coolLinter,
  }) = _AnalysisSettings;

  factory AnalysisSettings.fromJson(Map<String, dynamic> json) => _$AnalysisSettingsFromJson(json);

  /// use `always_specify_stream_subscription` rule
  bool get useAlwaysSpecifyStreamSub {
    return coolLinter?.extendedRules.contains('always_specify_stream_subscription') ?? false;
  }

  /// `always_specify_types` rule list
  static final List<String> alwaysSpecifyTypeRuleNameList = <String>[
    'typed_literal',
    'declared_identifier',
    'set_or_map_literal',
    'simple_formal_parameter',
    'type_name',
    'variable_declaration_list',
  ];

  /// use `always_specify_types` rule
  bool get useAlwaysSpecifyTypes {
    final List<String> typeNameList = coolLinter?.types ?? <String>[];

    final bool containsAnyOfRuleList = typeNameList.any(alwaysSpecifyTypeRuleNameList.contains);

    return containsAnyOfRuleList;
  }

  /// use `regexp_exclude` rule
  bool get useRegexpExclude {
    return coolLinter?.regexpExclude.isNotEmpty ?? false;
  }

  /// use `prefer_trailing_comma` rule
  bool get usePreferTrailingComma {
    return coolLinter?.preferTrailingComma != null;
  }
}

@freezed
class CoolLinter with _$CoolLinter {
  const CoolLinter._();

  const factory CoolLinter({
    // always_specify_types
    @Default(<String>[]) @JsonKey(name: 'always_specify_types', defaultValue: <String>[]) List<String> types,
    // regexp_exclude
    @Default(<ExcludeWord>[])
    @JsonKey(name: 'regexp_exclude', defaultValue: <ExcludeWord>[])
        List<ExcludeWord> regexpExclude,
    // exclude_folders
    @Default(<String>[]) @JsonKey(name: 'exclude_folders', defaultValue: <String>[]) List<String> excludeFolders,
    // extended_rules
    @Default(<String>[]) @JsonKey(name: 'extended_rules', defaultValue: <String>[]) List<String> extendedRules,
    // prefer_trailing_comma
    @JsonKey(name: 'prefer_trailing_comma') PreferTrailingComma? preferTrailingComma,
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

@freezed
class PreferTrailingComma with _$PreferTrailingComma {
  const PreferTrailingComma._();

  const factory PreferTrailingComma({
    @Default(2) @JsonKey(name: 'break-on') int breakOn,
  }) = _PreferTrailingComma;

  factory PreferTrailingComma.fromJson(Map<String, dynamic> json) => _$PreferTrailingCommaFromJson(json);
}

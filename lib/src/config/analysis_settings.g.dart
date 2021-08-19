// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnalysisSettings _$_$_AnalysisSettingsFromJson(Map<String, dynamic> json) {
  return _$_AnalysisSettings(
    coolLinter: json['cool_linter'] == null ? null : CoolLinter.fromJson(json['cool_linter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_AnalysisSettingsToJson(_$_AnalysisSettings instance) => <String, dynamic>{
      'cool_linter': instance.coolLinter,
    };

_$_CoolLinter _$_$_CoolLinterFromJson(Map<String, dynamic> json) {
  return _$_CoolLinter(
    types: (json['always_specify_types'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    regexpExclude: (json['regexp_exclude'] as List<dynamic>?)
            ?.map((e) => ExcludeWord.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    excludeFolders: (json['exclude_folders'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    extendedRules: (json['extended_rules'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    preferTrailingComma: json['prefer_trailing_comma'] == null
        ? null
        : PreferTrailingComma.fromJson(json['prefer_trailing_comma'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_CoolLinterToJson(_$_CoolLinter instance) => <String, dynamic>{
      'always_specify_types': instance.types,
      'regexp_exclude': instance.regexpExclude,
      'exclude_folders': instance.excludeFolders,
      'extended_rules': instance.extendedRules,
      'prefer_trailing_comma': instance.preferTrailingComma,
    };

_$_ExcludeWord _$_$_ExcludeWordFromJson(Map<String, dynamic> json) {
  return _$_ExcludeWord(
    json['pattern'] as String,
    hint: json['hint'] as String? ?? '',
    severity: json['severity'] as String? ?? 'WARNING',
  );
}

Map<String, dynamic> _$_$_ExcludeWordToJson(_$_ExcludeWord instance) => <String, dynamic>{
      'pattern': instance.pattern,
      'hint': instance.hint,
      'severity': instance.severity,
    };

_$_PreferTrailingComma _$_$_PreferTrailingCommaFromJson(Map<String, dynamic> json) {
  return _$_PreferTrailingComma(
    breakOn: json['break-on'] as int,
  );
}

Map<String, dynamic> _$_$_PreferTrailingCommaToJson(_$_PreferTrailingComma instance) => <String, dynamic>{
      'break-on': instance.breakOn,
    };

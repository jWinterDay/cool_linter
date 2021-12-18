// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnalysisSettings _$$_AnalysisSettingsFromJson(Map<String, dynamic> json) =>
    _$_AnalysisSettings(
      coolLinter: json['cool_linter'] == null
          ? const CoolLinter()
          : CoolLinter.fromJson(json['cool_linter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AnalysisSettingsToJson(_$_AnalysisSettings instance) =>
    <String, dynamic>{
      'cool_linter': instance.coolLinter,
    };

_$_CoolLinter _$$_CoolLinterFromJson(Map<String, dynamic> json) =>
    _$_CoolLinter(
      types: (json['always_specify_types'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      regexpExclude: (json['regexp_exclude'] as List<dynamic>?)
              ?.map((e) => ExcludeWord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      excludeFolders: (json['exclude_folders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      extendedRules: (json['extended_rules'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_CoolLinterToJson(_$_CoolLinter instance) =>
    <String, dynamic>{
      'always_specify_types': instance.types,
      'regexp_exclude': instance.regexpExclude,
      'exclude_folders': instance.excludeFolders,
      'extended_rules': instance.extendedRules,
    };

_$_ExcludeWord _$$_ExcludeWordFromJson(Map<String, dynamic> json) =>
    _$_ExcludeWord(
      pattern: json['pattern'] as String?,
      hint: json['hint'] as String? ?? '',
      severity: json['severity'] as String? ?? 'WARNING',
    );

Map<String, dynamic> _$$_ExcludeWordToJson(_$_ExcludeWord instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'hint': instance.hint,
      'severity': instance.severity,
    };

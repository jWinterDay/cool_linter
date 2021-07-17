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
            ?.map((e) => ExcludeWords.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    excludeFolders: (json['exclude_folders'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  );
}

Map<String, dynamic> _$_$_CoolLinterToJson(_$_CoolLinter instance) => <String, dynamic>{
      'always_specify_types': instance.types,
      'regexp_exclude': instance.regexpExclude,
      'exclude_folders': instance.excludeFolders,
    };

_$_ExcludeWords _$_$_ExcludeWordsFromJson(Map<String, dynamic> json) {
  return _$_ExcludeWords(
    json['pattern'] as String,
    hint: json['hint'] as String? ?? '',
    severity: json['severity'] as String? ?? 'WARNING',
  );
}

Map<String, dynamic> _$_$_ExcludeWordsToJson(_$_ExcludeWords instance) => <String, dynamic>{
      'pattern': instance.pattern,
      'hint': instance.hint,
      'severity': instance.severity,
    };

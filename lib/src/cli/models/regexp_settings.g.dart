// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regexp_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RegexpSettings _$_$_RegexpSettingsFromJson(Map<String, dynamic> json) {
  return _$_RegexpSettings(
    regexpExclude: (json['regexp_exclude'] as List<dynamic>?)
            ?.map((e) => ExcludeWord.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_RegexpSettingsToJson(_$_RegexpSettings instance) =>
    <String, dynamic>{
      'regexp_exclude': instance.regexpExclude,
    };

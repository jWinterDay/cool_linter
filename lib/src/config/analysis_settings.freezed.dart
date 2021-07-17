// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'analysis_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AnalysisSettings _$AnalysisSettingsFromJson(Map<String, dynamic> json) {
  return _AnalysisSettings.fromJson(json);
}

/// @nodoc
class _$AnalysisSettingsTearOff {
  const _$AnalysisSettingsTearOff();

  _AnalysisSettings call({@JsonKey(name: 'cool_linter') CoolLinter? coolLinter = const CoolLinter()}) {
    return _AnalysisSettings(
      coolLinter: coolLinter,
    );
  }

  AnalysisSettings fromJson(Map<String, Object> json) {
    return AnalysisSettings.fromJson(json);
  }
}

/// @nodoc
const $AnalysisSettings = _$AnalysisSettingsTearOff();

/// @nodoc
mixin _$AnalysisSettings {
  @JsonKey(name: 'cool_linter')
  CoolLinter? get coolLinter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnalysisSettingsCopyWith<AnalysisSettings> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisSettingsCopyWith<$Res> {
  factory $AnalysisSettingsCopyWith(AnalysisSettings value, $Res Function(AnalysisSettings) then) =
      _$AnalysisSettingsCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'cool_linter') CoolLinter? coolLinter});

  $CoolLinterCopyWith<$Res>? get coolLinter;
}

/// @nodoc
class _$AnalysisSettingsCopyWithImpl<$Res> implements $AnalysisSettingsCopyWith<$Res> {
  _$AnalysisSettingsCopyWithImpl(this._value, this._then);

  final AnalysisSettings _value;
  // ignore: unused_field
  final $Res Function(AnalysisSettings) _then;

  @override
  $Res call({
    Object? coolLinter = freezed,
  }) {
    return _then(_value.copyWith(
      coolLinter: coolLinter == freezed
          ? _value.coolLinter
          : coolLinter // ignore: cast_nullable_to_non_nullable
              as CoolLinter?,
    ));
  }

  @override
  $CoolLinterCopyWith<$Res>? get coolLinter {
    if (_value.coolLinter == null) {
      return null;
    }

    return $CoolLinterCopyWith<$Res>(_value.coolLinter!, (value) {
      return _then(_value.copyWith(coolLinter: value));
    });
  }
}

/// @nodoc
abstract class _$AnalysisSettingsCopyWith<$Res> implements $AnalysisSettingsCopyWith<$Res> {
  factory _$AnalysisSettingsCopyWith(_AnalysisSettings value, $Res Function(_AnalysisSettings) then) =
      __$AnalysisSettingsCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'cool_linter') CoolLinter? coolLinter});

  @override
  $CoolLinterCopyWith<$Res>? get coolLinter;
}

/// @nodoc
class __$AnalysisSettingsCopyWithImpl<$Res> extends _$AnalysisSettingsCopyWithImpl<$Res>
    implements _$AnalysisSettingsCopyWith<$Res> {
  __$AnalysisSettingsCopyWithImpl(_AnalysisSettings _value, $Res Function(_AnalysisSettings) _then)
      : super(_value, (v) => _then(v as _AnalysisSettings));

  @override
  _AnalysisSettings get _value => super._value as _AnalysisSettings;

  @override
  $Res call({
    Object? coolLinter = freezed,
  }) {
    return _then(_AnalysisSettings(
      coolLinter: coolLinter == freezed
          ? _value.coolLinter
          : coolLinter // ignore: cast_nullable_to_non_nullable
              as CoolLinter?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnalysisSettings extends _AnalysisSettings {
  const _$_AnalysisSettings({@JsonKey(name: 'cool_linter') this.coolLinter = const CoolLinter()}) : super._();

  factory _$_AnalysisSettings.fromJson(Map<String, dynamic> json) => _$_$_AnalysisSettingsFromJson(json);

  @override
  @JsonKey(name: 'cool_linter')
  final CoolLinter? coolLinter;

  @override
  String toString() {
    return 'AnalysisSettings(coolLinter: $coolLinter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnalysisSettings &&
            (identical(other.coolLinter, coolLinter) ||
                const DeepCollectionEquality().equals(other.coolLinter, coolLinter)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(coolLinter);

  @JsonKey(ignore: true)
  @override
  _$AnalysisSettingsCopyWith<_AnalysisSettings> get copyWith =>
      __$AnalysisSettingsCopyWithImpl<_AnalysisSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AnalysisSettingsToJson(this);
  }
}

abstract class _AnalysisSettings extends AnalysisSettings {
  const factory _AnalysisSettings({@JsonKey(name: 'cool_linter') CoolLinter? coolLinter}) = _$_AnalysisSettings;
  const _AnalysisSettings._() : super._();

  factory _AnalysisSettings.fromJson(Map<String, dynamic> json) = _$_AnalysisSettings.fromJson;

  @override
  @JsonKey(name: 'cool_linter')
  CoolLinter? get coolLinter => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AnalysisSettingsCopyWith<_AnalysisSettings> get copyWith => throw _privateConstructorUsedError;
}

CoolLinter _$CoolLinterFromJson(Map<String, dynamic> json) {
  return _CoolLinter.fromJson(json);
}

/// @nodoc
class _$CoolLinterTearOff {
  const _$CoolLinterTearOff();

  _CoolLinter call(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
          List<String> types = const <String>[],
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[])
          List<ExcludeWords> regexpExclude = const <ExcludeWords>[],
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
          List<String> excludeFolders = const <String>[]}) {
    return _CoolLinter(
      types: types,
      regexpExclude: regexpExclude,
      excludeFolders: excludeFolders,
    );
  }

  CoolLinter fromJson(Map<String, Object> json) {
    return CoolLinter.fromJson(json);
  }
}

/// @nodoc
const $CoolLinter = _$CoolLinterTearOff();

/// @nodoc
mixin _$CoolLinter {
  @JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
  List<String> get types => throw _privateConstructorUsedError;
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[])
  List<ExcludeWords> get regexpExclude => throw _privateConstructorUsedError;
  @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
  List<String> get excludeFolders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoolLinterCopyWith<CoolLinter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoolLinterCopyWith<$Res> {
  factory $CoolLinterCopyWith(CoolLinter value, $Res Function(CoolLinter) then) = _$CoolLinterCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[]) List<String> types,
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[]) List<ExcludeWords> regexpExclude,
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[]) List<String> excludeFolders});
}

/// @nodoc
class _$CoolLinterCopyWithImpl<$Res> implements $CoolLinterCopyWith<$Res> {
  _$CoolLinterCopyWithImpl(this._value, this._then);

  final CoolLinter _value;
  // ignore: unused_field
  final $Res Function(CoolLinter) _then;

  @override
  $Res call({
    Object? types = freezed,
    Object? regexpExclude = freezed,
    Object? excludeFolders = freezed,
  }) {
    return _then(_value.copyWith(
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regexpExclude: regexpExclude == freezed
          ? _value.regexpExclude
          : regexpExclude // ignore: cast_nullable_to_non_nullable
              as List<ExcludeWords>,
      excludeFolders: excludeFolders == freezed
          ? _value.excludeFolders
          : excludeFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$CoolLinterCopyWith<$Res> implements $CoolLinterCopyWith<$Res> {
  factory _$CoolLinterCopyWith(_CoolLinter value, $Res Function(_CoolLinter) then) = __$CoolLinterCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[]) List<String> types,
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[]) List<ExcludeWords> regexpExclude,
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[]) List<String> excludeFolders});
}

/// @nodoc
class __$CoolLinterCopyWithImpl<$Res> extends _$CoolLinterCopyWithImpl<$Res> implements _$CoolLinterCopyWith<$Res> {
  __$CoolLinterCopyWithImpl(_CoolLinter _value, $Res Function(_CoolLinter) _then)
      : super(_value, (v) => _then(v as _CoolLinter));

  @override
  _CoolLinter get _value => super._value as _CoolLinter;

  @override
  $Res call({
    Object? types = freezed,
    Object? regexpExclude = freezed,
    Object? excludeFolders = freezed,
  }) {
    return _then(_CoolLinter(
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regexpExclude: regexpExclude == freezed
          ? _value.regexpExclude
          : regexpExclude // ignore: cast_nullable_to_non_nullable
              as List<ExcludeWords>,
      excludeFolders: excludeFolders == freezed
          ? _value.excludeFolders
          : excludeFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CoolLinter extends _CoolLinter {
  const _$_CoolLinter(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
          this.types = const <String>[],
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[])
          this.regexpExclude = const <ExcludeWords>[],
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
          this.excludeFolders = const <String>[]})
      : super._();

  factory _$_CoolLinter.fromJson(Map<String, dynamic> json) => _$_$_CoolLinterFromJson(json);

  @override
  @JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
  final List<String> types;
  @override
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[])
  final List<ExcludeWords> regexpExclude;
  @override
  @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
  final List<String> excludeFolders;

  @override
  String toString() {
    return 'CoolLinter(types: $types, regexpExclude: $regexpExclude, excludeFolders: $excludeFolders)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CoolLinter &&
            (identical(other.types, types) || const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.regexpExclude, regexpExclude) ||
                const DeepCollectionEquality().equals(other.regexpExclude, regexpExclude)) &&
            (identical(other.excludeFolders, excludeFolders) ||
                const DeepCollectionEquality().equals(other.excludeFolders, excludeFolders)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(regexpExclude) ^
      const DeepCollectionEquality().hash(excludeFolders);

  @JsonKey(ignore: true)
  @override
  _$CoolLinterCopyWith<_CoolLinter> get copyWith => __$CoolLinterCopyWithImpl<_CoolLinter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CoolLinterToJson(this);
  }
}

abstract class _CoolLinter extends CoolLinter {
  const factory _CoolLinter(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[]) List<String> types,
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[]) List<ExcludeWords> regexpExclude,
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[]) List<String> excludeFolders}) = _$_CoolLinter;
  const _CoolLinter._() : super._();

  factory _CoolLinter.fromJson(Map<String, dynamic> json) = _$_CoolLinter.fromJson;

  @override
  @JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
  List<String> get types => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWords>[])
  List<ExcludeWords> get regexpExclude => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
  List<String> get excludeFolders => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CoolLinterCopyWith<_CoolLinter> get copyWith => throw _privateConstructorUsedError;
}

ExcludeWords _$ExcludeWordsFromJson(Map<String, dynamic> json) {
  return _ExcludeWords.fromJson(json);
}

/// @nodoc
class _$ExcludeWordsTearOff {
  const _$ExcludeWordsTearOff();

  _ExcludeWords call(String pattern, {String hint = '', String severity = 'WARNING'}) {
    return _ExcludeWords(
      pattern,
      hint: hint,
      severity: severity,
    );
  }

  ExcludeWords fromJson(Map<String, Object> json) {
    return ExcludeWords.fromJson(json);
  }
}

/// @nodoc
const $ExcludeWords = _$ExcludeWordsTearOff();

/// @nodoc
mixin _$ExcludeWords {
  String get pattern => throw _privateConstructorUsedError;
  String get hint => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExcludeWordsCopyWith<ExcludeWords> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExcludeWordsCopyWith<$Res> {
  factory $ExcludeWordsCopyWith(ExcludeWords value, $Res Function(ExcludeWords) then) =
      _$ExcludeWordsCopyWithImpl<$Res>;
  $Res call({String pattern, String hint, String severity});
}

/// @nodoc
class _$ExcludeWordsCopyWithImpl<$Res> implements $ExcludeWordsCopyWith<$Res> {
  _$ExcludeWordsCopyWithImpl(this._value, this._then);

  final ExcludeWords _value;
  // ignore: unused_field
  final $Res Function(ExcludeWords) _then;

  @override
  $Res call({
    Object? pattern = freezed,
    Object? hint = freezed,
    Object? severity = freezed,
  }) {
    return _then(_value.copyWith(
      pattern: pattern == freezed
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      hint: hint == freezed
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ExcludeWordsCopyWith<$Res> implements $ExcludeWordsCopyWith<$Res> {
  factory _$ExcludeWordsCopyWith(_ExcludeWords value, $Res Function(_ExcludeWords) then) =
      __$ExcludeWordsCopyWithImpl<$Res>;
  @override
  $Res call({String pattern, String hint, String severity});
}

/// @nodoc
class __$ExcludeWordsCopyWithImpl<$Res> extends _$ExcludeWordsCopyWithImpl<$Res>
    implements _$ExcludeWordsCopyWith<$Res> {
  __$ExcludeWordsCopyWithImpl(_ExcludeWords _value, $Res Function(_ExcludeWords) _then)
      : super(_value, (v) => _then(v as _ExcludeWords));

  @override
  _ExcludeWords get _value => super._value as _ExcludeWords;

  @override
  $Res call({
    Object? pattern = freezed,
    Object? hint = freezed,
    Object? severity = freezed,
  }) {
    return _then(_ExcludeWords(
      pattern == freezed
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      hint: hint == freezed
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExcludeWords extends _ExcludeWords {
  const _$_ExcludeWords(this.pattern, {this.hint = '', this.severity = 'WARNING'}) : super._();

  factory _$_ExcludeWords.fromJson(Map<String, dynamic> json) => _$_$_ExcludeWordsFromJson(json);

  @override
  final String pattern;
  @JsonKey(defaultValue: '')
  @override
  final String hint;
  @JsonKey(defaultValue: 'WARNING')
  @override
  final String severity;

  @override
  String toString() {
    return 'ExcludeWords(pattern: $pattern, hint: $hint, severity: $severity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ExcludeWords &&
            (identical(other.pattern, pattern) || const DeepCollectionEquality().equals(other.pattern, pattern)) &&
            (identical(other.hint, hint) || const DeepCollectionEquality().equals(other.hint, hint)) &&
            (identical(other.severity, severity) || const DeepCollectionEquality().equals(other.severity, severity)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pattern) ^
      const DeepCollectionEquality().hash(hint) ^
      const DeepCollectionEquality().hash(severity);

  @JsonKey(ignore: true)
  @override
  _$ExcludeWordsCopyWith<_ExcludeWords> get copyWith => __$ExcludeWordsCopyWithImpl<_ExcludeWords>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ExcludeWordsToJson(this);
  }
}

abstract class _ExcludeWords extends ExcludeWords {
  const factory _ExcludeWords(String pattern, {String hint, String severity}) = _$_ExcludeWords;
  const _ExcludeWords._() : super._();

  factory _ExcludeWords.fromJson(Map<String, dynamic> json) = _$_ExcludeWords.fromJson;

  @override
  String get pattern => throw _privateConstructorUsedError;
  @override
  String get hint => throw _privateConstructorUsedError;
  @override
  String get severity => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ExcludeWordsCopyWith<_ExcludeWords> get copyWith => throw _privateConstructorUsedError;
}

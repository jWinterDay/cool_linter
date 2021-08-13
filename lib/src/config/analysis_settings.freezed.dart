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
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
          List<ExcludeWord> regexpExclude = const <ExcludeWord>[],
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
          List<String> excludeFolders = const <String>[],
      @JsonKey(name: 'extended_rules', defaultValue: const <String>[])
          List<String> extendedRules = const <String>[],
      @JsonKey(name: 'prefer_trailing_comma')
          PreferTrailingComma? preferTrailingComma}) {
    return _CoolLinter(
      types: types,
      regexpExclude: regexpExclude,
      excludeFolders: excludeFolders,
      extendedRules: extendedRules,
      preferTrailingComma: preferTrailingComma,
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
// always_specify_types
  @JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
  List<String> get types => throw _privateConstructorUsedError; // regexp_exclude
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
  List<ExcludeWord> get regexpExclude => throw _privateConstructorUsedError; // exclude_folders
  @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
  List<String> get excludeFolders => throw _privateConstructorUsedError; // extended_rules
  @JsonKey(name: 'extended_rules', defaultValue: const <String>[])
  List<String> get extendedRules => throw _privateConstructorUsedError; // prefer_trailing_comma
  @JsonKey(name: 'prefer_trailing_comma')
  PreferTrailingComma? get preferTrailingComma => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoolLinterCopyWith<CoolLinter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoolLinterCopyWith<$Res> {
  factory $CoolLinterCopyWith(CoolLinter value, $Res Function(CoolLinter) then) = _$CoolLinterCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[]) List<String> types,
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[]) List<ExcludeWord> regexpExclude,
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[]) List<String> excludeFolders,
      @JsonKey(name: 'extended_rules', defaultValue: const <String>[]) List<String> extendedRules,
      @JsonKey(name: 'prefer_trailing_comma') PreferTrailingComma? preferTrailingComma});

  $PreferTrailingCommaCopyWith<$Res>? get preferTrailingComma;
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
    Object? extendedRules = freezed,
    Object? preferTrailingComma = freezed,
  }) {
    return _then(_value.copyWith(
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regexpExclude: regexpExclude == freezed
          ? _value.regexpExclude
          : regexpExclude // ignore: cast_nullable_to_non_nullable
              as List<ExcludeWord>,
      excludeFolders: excludeFolders == freezed
          ? _value.excludeFolders
          : excludeFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
      extendedRules: extendedRules == freezed
          ? _value.extendedRules
          : extendedRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferTrailingComma: preferTrailingComma == freezed
          ? _value.preferTrailingComma
          : preferTrailingComma // ignore: cast_nullable_to_non_nullable
              as PreferTrailingComma?,
    ));
  }

  @override
  $PreferTrailingCommaCopyWith<$Res>? get preferTrailingComma {
    if (_value.preferTrailingComma == null) {
      return null;
    }

    return $PreferTrailingCommaCopyWith<$Res>(_value.preferTrailingComma!, (value) {
      return _then(_value.copyWith(preferTrailingComma: value));
    });
  }
}

/// @nodoc
abstract class _$CoolLinterCopyWith<$Res> implements $CoolLinterCopyWith<$Res> {
  factory _$CoolLinterCopyWith(_CoolLinter value, $Res Function(_CoolLinter) then) = __$CoolLinterCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[]) List<String> types,
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[]) List<ExcludeWord> regexpExclude,
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[]) List<String> excludeFolders,
      @JsonKey(name: 'extended_rules', defaultValue: const <String>[]) List<String> extendedRules,
      @JsonKey(name: 'prefer_trailing_comma') PreferTrailingComma? preferTrailingComma});

  @override
  $PreferTrailingCommaCopyWith<$Res>? get preferTrailingComma;
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
    Object? extendedRules = freezed,
    Object? preferTrailingComma = freezed,
  }) {
    return _then(_CoolLinter(
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regexpExclude: regexpExclude == freezed
          ? _value.regexpExclude
          : regexpExclude // ignore: cast_nullable_to_non_nullable
              as List<ExcludeWord>,
      excludeFolders: excludeFolders == freezed
          ? _value.excludeFolders
          : excludeFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
      extendedRules: extendedRules == freezed
          ? _value.extendedRules
          : extendedRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferTrailingComma: preferTrailingComma == freezed
          ? _value.preferTrailingComma
          : preferTrailingComma // ignore: cast_nullable_to_non_nullable
              as PreferTrailingComma?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CoolLinter extends _CoolLinter {
  const _$_CoolLinter(
      {@JsonKey(name: 'always_specify_types', defaultValue: const <String>[]) this.types = const <String>[],
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[]) this.regexpExclude = const <ExcludeWord>[],
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[]) this.excludeFolders = const <String>[],
      @JsonKey(name: 'extended_rules', defaultValue: const <String>[]) this.extendedRules = const <String>[],
      @JsonKey(name: 'prefer_trailing_comma') this.preferTrailingComma})
      : super._();

  factory _$_CoolLinter.fromJson(Map<String, dynamic> json) => _$_$_CoolLinterFromJson(json);

  @override // always_specify_types
  @JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
  final List<String> types;
  @override // regexp_exclude
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
  final List<ExcludeWord> regexpExclude;
  @override // exclude_folders
  @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
  final List<String> excludeFolders;
  @override // extended_rules
  @JsonKey(name: 'extended_rules', defaultValue: const <String>[])
  final List<String> extendedRules;
  @override // prefer_trailing_comma
  @JsonKey(name: 'prefer_trailing_comma')
  final PreferTrailingComma? preferTrailingComma;

  @override
  String toString() {
    return 'CoolLinter(types: $types, regexpExclude: $regexpExclude, excludeFolders: $excludeFolders, extendedRules: $extendedRules, preferTrailingComma: $preferTrailingComma)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CoolLinter &&
            (identical(other.types, types) || const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.regexpExclude, regexpExclude) ||
                const DeepCollectionEquality().equals(other.regexpExclude, regexpExclude)) &&
            (identical(other.excludeFolders, excludeFolders) ||
                const DeepCollectionEquality().equals(other.excludeFolders, excludeFolders)) &&
            (identical(other.extendedRules, extendedRules) ||
                const DeepCollectionEquality().equals(other.extendedRules, extendedRules)) &&
            (identical(other.preferTrailingComma, preferTrailingComma) ||
                const DeepCollectionEquality().equals(other.preferTrailingComma, preferTrailingComma)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(regexpExclude) ^
      const DeepCollectionEquality().hash(excludeFolders) ^
      const DeepCollectionEquality().hash(extendedRules) ^
      const DeepCollectionEquality().hash(preferTrailingComma);

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
      @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[]) List<ExcludeWord> regexpExclude,
      @JsonKey(name: 'exclude_folders', defaultValue: const <String>[]) List<String> excludeFolders,
      @JsonKey(name: 'extended_rules', defaultValue: const <String>[]) List<String> extendedRules,
      @JsonKey(name: 'prefer_trailing_comma') PreferTrailingComma? preferTrailingComma}) = _$_CoolLinter;
  const _CoolLinter._() : super._();

  factory _CoolLinter.fromJson(Map<String, dynamic> json) = _$_CoolLinter.fromJson;

  @override // always_specify_types
  @JsonKey(name: 'always_specify_types', defaultValue: const <String>[])
  List<String> get types => throw _privateConstructorUsedError;
  @override // regexp_exclude
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
  List<ExcludeWord> get regexpExclude => throw _privateConstructorUsedError;
  @override // exclude_folders
  @JsonKey(name: 'exclude_folders', defaultValue: const <String>[])
  List<String> get excludeFolders => throw _privateConstructorUsedError;
  @override // extended_rules
  @JsonKey(name: 'extended_rules', defaultValue: const <String>[])
  List<String> get extendedRules => throw _privateConstructorUsedError;
  @override // prefer_trailing_comma
  @JsonKey(name: 'prefer_trailing_comma')
  PreferTrailingComma? get preferTrailingComma => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CoolLinterCopyWith<_CoolLinter> get copyWith => throw _privateConstructorUsedError;
}

ExcludeWord _$ExcludeWordFromJson(Map<String, dynamic> json) {
  return _ExcludeWord.fromJson(json);
}

/// @nodoc
class _$ExcludeWordTearOff {
  const _$ExcludeWordTearOff();

  _ExcludeWord call(String pattern, {String hint = '', String severity = 'WARNING'}) {
    return _ExcludeWord(
      pattern,
      hint: hint,
      severity: severity,
    );
  }

  ExcludeWord fromJson(Map<String, Object> json) {
    return ExcludeWord.fromJson(json);
  }
}

/// @nodoc
const $ExcludeWord = _$ExcludeWordTearOff();

/// @nodoc
mixin _$ExcludeWord {
  String get pattern => throw _privateConstructorUsedError;
  String get hint => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExcludeWordCopyWith<ExcludeWord> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExcludeWordCopyWith<$Res> {
  factory $ExcludeWordCopyWith(ExcludeWord value, $Res Function(ExcludeWord) then) = _$ExcludeWordCopyWithImpl<$Res>;
  $Res call({String pattern, String hint, String severity});
}

/// @nodoc
class _$ExcludeWordCopyWithImpl<$Res> implements $ExcludeWordCopyWith<$Res> {
  _$ExcludeWordCopyWithImpl(this._value, this._then);

  final ExcludeWord _value;
  // ignore: unused_field
  final $Res Function(ExcludeWord) _then;

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
abstract class _$ExcludeWordCopyWith<$Res> implements $ExcludeWordCopyWith<$Res> {
  factory _$ExcludeWordCopyWith(_ExcludeWord value, $Res Function(_ExcludeWord) then) =
      __$ExcludeWordCopyWithImpl<$Res>;
  @override
  $Res call({String pattern, String hint, String severity});
}

/// @nodoc
class __$ExcludeWordCopyWithImpl<$Res> extends _$ExcludeWordCopyWithImpl<$Res> implements _$ExcludeWordCopyWith<$Res> {
  __$ExcludeWordCopyWithImpl(_ExcludeWord _value, $Res Function(_ExcludeWord) _then)
      : super(_value, (v) => _then(v as _ExcludeWord));

  @override
  _ExcludeWord get _value => super._value as _ExcludeWord;

  @override
  $Res call({
    Object? pattern = freezed,
    Object? hint = freezed,
    Object? severity = freezed,
  }) {
    return _then(_ExcludeWord(
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
class _$_ExcludeWord extends _ExcludeWord {
  const _$_ExcludeWord(this.pattern, {this.hint = '', this.severity = 'WARNING'}) : super._();

  factory _$_ExcludeWord.fromJson(Map<String, dynamic> json) => _$_$_ExcludeWordFromJson(json);

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
    return 'ExcludeWord(pattern: $pattern, hint: $hint, severity: $severity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ExcludeWord &&
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
  _$ExcludeWordCopyWith<_ExcludeWord> get copyWith => __$ExcludeWordCopyWithImpl<_ExcludeWord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ExcludeWordToJson(this);
  }
}

abstract class _ExcludeWord extends ExcludeWord {
  const factory _ExcludeWord(String pattern, {String hint, String severity}) = _$_ExcludeWord;
  const _ExcludeWord._() : super._();

  factory _ExcludeWord.fromJson(Map<String, dynamic> json) = _$_ExcludeWord.fromJson;

  @override
  String get pattern => throw _privateConstructorUsedError;
  @override
  String get hint => throw _privateConstructorUsedError;
  @override
  String get severity => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ExcludeWordCopyWith<_ExcludeWord> get copyWith => throw _privateConstructorUsedError;
}

PreferTrailingComma _$PreferTrailingCommaFromJson(Map<String, dynamic> json) {
  return _PreferTrailingComma.fromJson(json);
}

/// @nodoc
class _$PreferTrailingCommaTearOff {
  const _$PreferTrailingCommaTearOff();

  _PreferTrailingComma call({@JsonKey(name: 'break-on') int breakOn = 2}) {
    return _PreferTrailingComma(
      breakOn: breakOn,
    );
  }

  PreferTrailingComma fromJson(Map<String, Object> json) {
    return PreferTrailingComma.fromJson(json);
  }
}

/// @nodoc
const $PreferTrailingComma = _$PreferTrailingCommaTearOff();

/// @nodoc
mixin _$PreferTrailingComma {
  @JsonKey(name: 'break-on')
  int get breakOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferTrailingCommaCopyWith<PreferTrailingComma> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferTrailingCommaCopyWith<$Res> {
  factory $PreferTrailingCommaCopyWith(PreferTrailingComma value, $Res Function(PreferTrailingComma) then) =
      _$PreferTrailingCommaCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'break-on') int breakOn});
}

/// @nodoc
class _$PreferTrailingCommaCopyWithImpl<$Res> implements $PreferTrailingCommaCopyWith<$Res> {
  _$PreferTrailingCommaCopyWithImpl(this._value, this._then);

  final PreferTrailingComma _value;
  // ignore: unused_field
  final $Res Function(PreferTrailingComma) _then;

  @override
  $Res call({
    Object? breakOn = freezed,
  }) {
    return _then(_value.copyWith(
      breakOn: breakOn == freezed
          ? _value.breakOn
          : breakOn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$PreferTrailingCommaCopyWith<$Res> implements $PreferTrailingCommaCopyWith<$Res> {
  factory _$PreferTrailingCommaCopyWith(_PreferTrailingComma value, $Res Function(_PreferTrailingComma) then) =
      __$PreferTrailingCommaCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'break-on') int breakOn});
}

/// @nodoc
class __$PreferTrailingCommaCopyWithImpl<$Res> extends _$PreferTrailingCommaCopyWithImpl<$Res>
    implements _$PreferTrailingCommaCopyWith<$Res> {
  __$PreferTrailingCommaCopyWithImpl(_PreferTrailingComma _value, $Res Function(_PreferTrailingComma) _then)
      : super(_value, (v) => _then(v as _PreferTrailingComma));

  @override
  _PreferTrailingComma get _value => super._value as _PreferTrailingComma;

  @override
  $Res call({
    Object? breakOn = freezed,
  }) {
    return _then(_PreferTrailingComma(
      breakOn: breakOn == freezed
          ? _value.breakOn
          : breakOn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreferTrailingComma extends _PreferTrailingComma {
  const _$_PreferTrailingComma({@JsonKey(name: 'break-on') this.breakOn = 2}) : super._();

  factory _$_PreferTrailingComma.fromJson(Map<String, dynamic> json) => _$_$_PreferTrailingCommaFromJson(json);

  @override
  @JsonKey(name: 'break-on')
  final int breakOn;

  @override
  String toString() {
    return 'PreferTrailingComma(breakOn: $breakOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PreferTrailingComma &&
            (identical(other.breakOn, breakOn) || const DeepCollectionEquality().equals(other.breakOn, breakOn)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(breakOn);

  @JsonKey(ignore: true)
  @override
  _$PreferTrailingCommaCopyWith<_PreferTrailingComma> get copyWith =>
      __$PreferTrailingCommaCopyWithImpl<_PreferTrailingComma>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PreferTrailingCommaToJson(this);
  }
}

abstract class _PreferTrailingComma extends PreferTrailingComma {
  const factory _PreferTrailingComma({@JsonKey(name: 'break-on') int breakOn}) = _$_PreferTrailingComma;
  const _PreferTrailingComma._() : super._();

  factory _PreferTrailingComma.fromJson(Map<String, dynamic> json) = _$_PreferTrailingComma.fromJson;

  @override
  @JsonKey(name: 'break-on')
  int get breakOn => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PreferTrailingCommaCopyWith<_PreferTrailingComma> get copyWith => throw _privateConstructorUsedError;
}

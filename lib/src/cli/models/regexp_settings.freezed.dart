// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'regexp_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RegexpSettings _$RegexpSettingsFromJson(Map<String, dynamic> json) {
  return _RegexpSettings.fromJson(json);
}

/// @nodoc
class _$RegexpSettingsTearOff {
  const _$RegexpSettingsTearOff();

  _RegexpSettings call(
      {@JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
          List<ExcludeWord> regexpExclude = const <ExcludeWord>[]}) {
    return _RegexpSettings(
      regexpExclude: regexpExclude,
    );
  }

  RegexpSettings fromJson(Map<String, Object> json) {
    return RegexpSettings.fromJson(json);
  }
}

/// @nodoc
const $RegexpSettings = _$RegexpSettingsTearOff();

/// @nodoc
mixin _$RegexpSettings {
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
  List<ExcludeWord> get regexpExclude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegexpSettingsCopyWith<RegexpSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegexpSettingsCopyWith<$Res> {
  factory $RegexpSettingsCopyWith(
          RegexpSettings value, $Res Function(RegexpSettings) then) =
      _$RegexpSettingsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
          List<ExcludeWord> regexpExclude});
}

/// @nodoc
class _$RegexpSettingsCopyWithImpl<$Res>
    implements $RegexpSettingsCopyWith<$Res> {
  _$RegexpSettingsCopyWithImpl(this._value, this._then);

  final RegexpSettings _value;
  // ignore: unused_field
  final $Res Function(RegexpSettings) _then;

  @override
  $Res call({
    Object? regexpExclude = freezed,
  }) {
    return _then(_value.copyWith(
      regexpExclude: regexpExclude == freezed
          ? _value.regexpExclude
          : regexpExclude // ignore: cast_nullable_to_non_nullable
              as List<ExcludeWord>,
    ));
  }
}

/// @nodoc
abstract class _$RegexpSettingsCopyWith<$Res>
    implements $RegexpSettingsCopyWith<$Res> {
  factory _$RegexpSettingsCopyWith(
          _RegexpSettings value, $Res Function(_RegexpSettings) then) =
      __$RegexpSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
          List<ExcludeWord> regexpExclude});
}

/// @nodoc
class __$RegexpSettingsCopyWithImpl<$Res>
    extends _$RegexpSettingsCopyWithImpl<$Res>
    implements _$RegexpSettingsCopyWith<$Res> {
  __$RegexpSettingsCopyWithImpl(
      _RegexpSettings _value, $Res Function(_RegexpSettings) _then)
      : super(_value, (v) => _then(v as _RegexpSettings));

  @override
  _RegexpSettings get _value => super._value as _RegexpSettings;

  @override
  $Res call({
    Object? regexpExclude = freezed,
  }) {
    return _then(_RegexpSettings(
      regexpExclude: regexpExclude == freezed
          ? _value.regexpExclude
          : regexpExclude // ignore: cast_nullable_to_non_nullable
              as List<ExcludeWord>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RegexpSettings extends _RegexpSettings {
  const _$_RegexpSettings(
      {@JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
          this.regexpExclude = const <ExcludeWord>[]})
      : super._();

  factory _$_RegexpSettings.fromJson(Map<String, dynamic> json) =>
      _$_$_RegexpSettingsFromJson(json);

  @override
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
  final List<ExcludeWord> regexpExclude;

  @override
  String toString() {
    return 'RegexpSettings(regexpExclude: $regexpExclude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RegexpSettings &&
            (identical(other.regexpExclude, regexpExclude) ||
                const DeepCollectionEquality()
                    .equals(other.regexpExclude, regexpExclude)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(regexpExclude);

  @JsonKey(ignore: true)
  @override
  _$RegexpSettingsCopyWith<_RegexpSettings> get copyWith =>
      __$RegexpSettingsCopyWithImpl<_RegexpSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RegexpSettingsToJson(this);
  }
}

abstract class _RegexpSettings extends RegexpSettings {
  const factory _RegexpSettings(
      {@JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
          List<ExcludeWord> regexpExclude}) = _$_RegexpSettings;
  const _RegexpSettings._() : super._();

  factory _RegexpSettings.fromJson(Map<String, dynamic> json) =
      _$_RegexpSettings.fromJson;

  @override
  @JsonKey(name: 'regexp_exclude', defaultValue: const <ExcludeWord>[])
  List<ExcludeWord> get regexpExclude => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RegexpSettingsCopyWith<_RegexpSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'regexp_settings.freezed.dart';
part 'regexp_settings.g.dart';

/// ```yaml
///regexp_exclude:
///  -
///    pattern: Colors
///    hint: Use colors from design system instead!
///    severity: WARNING
/// ```
@freezed
class RegexpSettings with _$RegexpSettings {
  const RegexpSettings._();

  const factory RegexpSettings({
    @Default(<ExcludeWord>[])
    @JsonKey(name: 'regexp_exclude', defaultValue: <ExcludeWord>[])
        List<ExcludeWord> regexpExclude,
  }) = _RegexpSettings;

  factory RegexpSettings.fromJson(Map<String, dynamic> json) =>
      _$RegexpSettingsFromJson(json);

  bool get existsAtLeastOneRegExp {
    return regexpExclude.any((ExcludeWord item) {
      return item.patternRegExp != null;
    });
  }

  Iterable<ExcludeWord> get regexpExcludeSafeList {
    return regexpExclude.where((ExcludeWord item) {
      return item.patternRegExp != null;
    });
  }
}

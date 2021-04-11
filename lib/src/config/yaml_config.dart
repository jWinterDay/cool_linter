import 'dart:convert';

import 'package:analyzer/file_system/file_system.dart';
import 'package:yaml/yaml.dart';

// ignore_for_file: avoid_as
class YamlConfig {
  YamlConfig({
    this.coolLinter,
  });

  factory YamlConfig.fromJson(String str) => YamlConfig.fromMap(json.decode(str) as Map<String, dynamic>);

  factory YamlConfig.fromMap(Map<dynamic, dynamic> json) {
    return YamlConfig(
      coolLinter: json['cool_linter'] == null ? null : CoolLinter.fromMap(json['cool_linter'] as Map<String, dynamic>),
    );
  }

  factory YamlConfig.fromFile(File file) {
    final String rawYaml = json.encode(loadYaml(file.readAsStringSync()));
    final YamlConfig yamlConfig = YamlConfig.fromJson(rawYaml);

    return yamlConfig;
  }

  final CoolLinter? coolLinter;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cool_linter': coolLinter?.toMap(),
    };
  }

  /// return null if correct
  String? get checkCorrectMessage {
    // exclude word list
    if (coolLinter?.excludeWords == null) {
      return 'exclude_words param list cannot be null';
    }

    if (coolLinter!.excludeWords!.isEmpty) {
      return 'exclude_words param list cannot be empty';
    }

    return null;
  }

  @override
  String toString() {
    return 'coolLinter: $coolLinter';
  }
}

class CoolLinter {
  CoolLinter({
    this.excludeWords,
    this.excludeFolders,
  });

  factory CoolLinter.fromJson(String str) {
    return CoolLinter.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  factory CoolLinter.fromMap(Map<String, dynamic> json) {
    return CoolLinter(
      excludeWords: json['exclude_words'] == null
          ? null
          : List<ExcludeWord>.from(
              (json['exclude_words'] as List<dynamic>).map<ExcludeWord>(
                (dynamic x) => ExcludeWord.fromMap(x as Map<String, dynamic>),
              ),
            ),
      excludeFolders: json['exclude_folders'] == null
          ? null
          : List<String>.from(
              (json['exclude_folders'] as List<dynamic>).map<String>(
                (dynamic x) => x.toString(),
              ),
            ),
    );
  }

  final List<ExcludeWord>? excludeWords;
  final List<String>? excludeFolders;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exclude_words': excludeWords == null
          ? null
          : List<dynamic>.from(
              excludeWords!.map<Map<String, dynamic>>(
                (ExcludeWord x) => x.toMap(),
              ),
            ),
      'exclude_folders': excludeFolders == null
          ? null
          : List<dynamic>.from(
              excludeFolders!.map<String>(
                (dynamic x) => x.toString(),
              ),
            ),
    };
  }

  @override
  String toString() {
    return 'excludeWords: $excludeWords, excludeFolders: $excludeFolders';
  }
}

const String defaultSeverity = 'warning';

class ExcludeWord {
  ExcludeWord({
    this.pattern,
    this.hint,
    this.severity = defaultSeverity,
  });

  factory ExcludeWord.fromJson(String str) {
    return ExcludeWord.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  factory ExcludeWord.fromMap(Map<String, dynamic> json) {
    return ExcludeWord(
      pattern: json['pattern'] == null ? null : json['pattern'].toString(),
      hint: json['hint'] == null ? null : json['hint'].toString(),
      severity: json['severity'] == null ? defaultSeverity : json['severity'].toString(),
    );
  }

  final String? pattern;
  final String? hint;
  final String? severity;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pattern': pattern,
      'hint': hint,
      'severity': severity == null ? defaultSeverity : hint,
    };
  }

  static final List<String> possibleSeverityValues = <String>[
    'INFO',
    'WARNING',
    'ERROR',
  ];

  static const String defaultSeverityVal = 'WARNING';

  String get safeSeverity {
    return possibleSeverityValues.firstWhere(
      (String val) {
        return val == severity;
      },
      orElse: () {
        return defaultSeverityVal;
      },
    );
  }

  @override
  String toString() {
    return '$pattern: $hint severity: $severity';
  }
}

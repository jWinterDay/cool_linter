import 'dart:convert';

// ignore_for_file: avoid_as
class YamlConfig {
  YamlConfig({
    this.analyzer,
    this.coolLinter,
  });

  factory YamlConfig.fromJson(String str) => YamlConfig.fromMap(json.decode(str) as Map<String, dynamic>);

  factory YamlConfig.fromMap(Map<String, dynamic> json) {
    return YamlConfig(
      analyzer: json['analyzer'] == null ? null : Analyzer.fromMap(json['analyzer'] as Map<String, dynamic>),
      coolLinter: json['cool_linter'] == null ? null : CoolLinter.fromMap(json['cool_linter'] as Map<String, dynamic>),
    );
  }

  final Analyzer analyzer;
  final CoolLinter coolLinter;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'analyzer': analyzer == null ? null : analyzer.toMap(),
      'cool_linter': coolLinter == null ? null : coolLinter.toMap(),
    };
  }

  @override
  String toString() {
    return 'analyzer: $analyzer, coolLinter: $coolLinter';
  }
}

class Analyzer {
  Analyzer({
    this.plugins,
  });

  factory Analyzer.fromJson(String str) {
    return Analyzer.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  factory Analyzer.fromMap(Map<String, dynamic> json) {
    return Analyzer(
      plugins: json['plugins'] == null
          ? null
          : List<String>.from((json['plugins'] as List<dynamic>).map<String>((dynamic x) => x.toString())),
    );
  }

  final List<String> plugins;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'plugins': plugins == null ? null : List<dynamic>.from(plugins.map<String>((String x) => x)),
    };
  }

  @override
  String toString() {
    return 'plugins: $plugins';
  }
}

class CoolLinter {
  CoolLinter({
    this.excludeWords,
    // required this.excludeFolders,
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
      // excludeFolders: json['exclude_folders'] == null
      //     ? null
      //     : List<dynamic>.from(
      //         (json['exclude_folders'] as List<dynamic>).map<String>(
      //           (dynamic x) => x.toString(),
      //         ),
      //       ),
    );
  }

  final List<ExcludeWord> excludeWords;
  // final List<String>? excludeFolders;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exclude_words': excludeWords == null
          ? null
          : List<dynamic>.from(
              excludeWords.map<Map<String, dynamic>>(
                (ExcludeWord x) => x.toMap(),
              ),
            ),
      // 'exclude_folders': excludeFolders == null
      //     ? null
      //     : List<dynamic>.from(
      //         excludeFolders!.map<String>(
      //           (dynamic x) => x.toString(),
      //         ),
      //       ),
    };
  }

  @override
  String toString() {
    return 'excludeWords: $excludeWords'; //, excludeFolders: $excludeFolders';
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

  final String pattern;
  final String hint;
  final String severity;

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

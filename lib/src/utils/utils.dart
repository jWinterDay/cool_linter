import 'dart:convert';

import 'package:analyzer/file_system/file_system.dart';
import 'package:cool_linter/src/config/analysis_settings.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// folder's name in format without slashes
/// used in [plugin.dart]
/// ``` dart
/// '.dart_tool',
/// '.vscode',
/// ```
const List<String> kDefaultExcludedFolders = <String>[
  '.dart_tool',
  '.vscode',
  'packages',
  'ios',
  'macos',
  'android',
  'web',
  'linux',
  'windows',
  'go',
];

/// folder's name in format with slashes
/// used in [yaml_config_extension.dart]
/// ``` dart
/// '.dart_tool/**',
/// '.vscode/**',
/// ```
final List<String> kDefaultExcludedFoldersYaml = kDefaultExcludedFolders.map((String e) {
  return e + '/**';
}).toList();

const List<String> possibleSeverityValues = <String>[
  'INFO',
  'WARNING',
  'ERROR',
];

abstract class AnalysisSettingsUtil {
  static Map<String, dynamic> convertYamlToMap(String str) {
    final dynamic rawMap = json.decode(json.encode(loadYaml(str)));
    if (rawMap is! Map<String, dynamic>) {
      throw ArgumentError('Wrong yaml source');
    }

    return rawMap;
  }

  static AnalysisSettings? getAnalysisSettingsFromFile(File? file) {
    if (file == null) {
      return null;
    }

    final String yaml = file.readAsStringSync();

    return AnalysisSettings.fromJson(convertYamlToMap(yaml));
  }

  static List<Glob> excludesGlobList(String root, AnalysisSettings analysisSettings) {
    final Iterable<String> patterns = analysisSettings.coolLinter?.excludeFolders ?? <String>[];

    return <String>[
      ...kDefaultExcludedFoldersYaml,
      ...patterns,
    ].map((String folder) {
      return Glob(p.join(root, folder));
    }).toList();
  }

  static bool isExcluded(String? path, Iterable<Glob> excludes) {
    if (path == null) {
      return false;
    }

    return excludes.any((Glob exclude) {
      return exclude.matches(path);
    });
  }
}

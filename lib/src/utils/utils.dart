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

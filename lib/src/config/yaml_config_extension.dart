import 'package:cool_linter/src/config/yaml_config.dart';

import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:analyzer/dart/analysis/results.dart';

const List<String> kDefaultExcludedFolders = <String>[
  '.dart_tool/**',
  '.vscode/**',
  'packages/**',
  'ios/**',
  'macos/**',
  'web/**',
  'linux/**',
  'windows/**',
  'go/**',
];

extension YamlConfigExtension on YamlConfig {
  List<Glob> excludesGlobList(String root) {
    final Iterable<String> patterns = this.coolLinter?.excludeFolders ?? <String>[];

    return <String>[
      ...kDefaultExcludedFolders,
      ...patterns,
    ].map((String folder) {
      return Glob(p.join(root, folder));
    }).toList();
  }

  bool isExcluded(AnalysisResult result, Iterable<Glob> excludes) {
    return excludes.any((Glob exclude) {
      return exclude.matches(result.path);
    });
  }
}

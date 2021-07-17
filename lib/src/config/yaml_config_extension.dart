import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:cool_linter/src/utils/utils.dart';

import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:analyzer/dart/analysis/results.dart';

extension YamlConfigExtension on YamlConfig {
  List<Glob> excludesGlobList(String root) {
    final Iterable<String> patterns = this.coolLinter?.excludeFolders ?? <String>[];

    return <String>[
      ...kDefaultExcludedFoldersYaml,
      ...patterns,
    ].map((String folder) {
      return Glob(p.join(root, folder));
    }).toList();
  }

  bool isExcluded(AnalysisResult result, Iterable<Glob> excludes) {
    if (result.path == null) {
      return false;
    }

    return excludes.any((Glob exclude) {
      return exclude.matches(result.path!);
    });
  }
}

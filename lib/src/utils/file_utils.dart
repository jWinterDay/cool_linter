import 'dart:io';

import 'package:file/local.dart';
import 'package:glob/glob.dart';

abstract class FileUtil {
  static Set<String> getDartFilesFromFolders(
    Iterable<String> folders,
    String rootFolder, {
    Iterable<String> excludedExtensions = const <String>[],
    // Iterable<Glob> globalExcludes = const <Glob>[],
  }) {
    return folders.expand((String directory) {
      return Glob('$directory/**.dart')
          .listFileSystemSync(
            const LocalFileSystem(),
            root: rootFolder,
            followLinks: false,
          )
          .whereType<File>()
          .where((File file) {
        final bool excluded = excludedExtensions.any((String excludedExtension) {
          return file.path.endsWith(excludedExtension);
        });

        return !excluded;
      }).map((File entity) {
        return entity.path;
      });
    }).toSet();
  }
}

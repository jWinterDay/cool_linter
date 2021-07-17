import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:path/path.dart';

Future<ResolvedUnitResult> getResolvedUnitResult(String path) async {
  final File file = File(path);
  if (!file.existsSync()) {
    throw ArgumentError(
      'Unable to find a file for the given path: $path',
    );
  }

  final String filePath = normalize(file.absolute.path);
  final SomeResolvedUnitResult parseResult = await resolveFile2(path: filePath);
  if (parseResult is! ResolvedUnitResult) {
    throw ArgumentError(
      'Unable to correctly resolve file for given path: $path',
    );
  }

  return parseResult;
}

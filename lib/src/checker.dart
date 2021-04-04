import 'package:analyzer/dart/analysis/results.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

class Checker {
  Future<List<int>> getIncorrectLines(String src, Pattern pattern) async {
    final ParseStringResult parseResult = parseString(
      content: src,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version.parse('2.12.0'),
        flags: <String>[],
      ),
      throwIfDiagnostics: false,
    );

    final List<int> lineStarts = parseResult.lineInfo.lineStarts;
    int prevIndex = 0;
    int columnIndex = 0;
    final List<int> matchIndexList = <int>[];

    lineStarts.forEach((int lineStartIndex) {
      if (lineStartIndex == 0) return;

      final String lineStr = src.substring(prevIndex, lineStartIndex);
      prevIndex = lineStartIndex;

      // is comment
      final bool isComment = lineStr.trimLeft().startsWith('//');

      if (!isComment && lineStr.contains(pattern)) {
        matchIndexList.add(columnIndex);
      }

      columnIndex++;
    });

    return matchIndexList;
  }

  Map<AnalysisError, PrioritizedSourceChange> checkResult({
    required List<int> incorrectLines,
    required Pattern pattern,
    // required String fullName,
    required ParseStringResult parseResult,
    AnalysisErrorSeverity? errorSeverity = AnalysisErrorSeverity.WARNING,
  }) {
    final Map<AnalysisError, PrioritizedSourceChange> result = <AnalysisError, PrioritizedSourceChange>{};

    incorrectLines.forEach((int lineIndex) {
      final PrioritizedSourceChange fix = PrioritizedSourceChange(
        1000000,
        SourceChange(
          'Apply fixes for cool_linter.',
          edits: <SourceFileEdit>[
            SourceFileEdit(
              'TODO fullName', // compilationUnit.source.fullName,
              1, //compilationUnit.source.modificationStamp,
              edits: <SourceEdit>[
                SourceEdit(1, 2, 'need to replace by pattern: $pattern'),
              ],
            )
          ],
        ),
      );

      final AnalysisError error = AnalysisError(
        errorSeverity ?? AnalysisErrorSeverity.WARNING,
        AnalysisErrorType.LINT,
        Location(
          'file', // compilationUnit.source.fullName,
          1, // offset
          1, // length
          lineIndex, // startLine
          1, // startColumn
          1, // endLine
          1, // endColumn
        ),
        'Class needs fixes for pattern: $pattern',
        'cool_linter_needs_fixes',
      );

      result[error] = fix;
    });

    return result;
  }
}

// Map<AnalysisError, PrioritizedSourceChange> check(String src, Pattern pattern) {
//   final Map<AnalysisError, PrioritizedSourceChange> result = <AnalysisError, PrioritizedSourceChange>{};

//   final ParseStringResult parseResult = parseString(
//     content: src,
//     featureSet: FeatureSet.fromEnableFlags2(
//       sdkLanguageVersion: Version.parse('2.12.0'),
//       flags: <String>[],
//     ),
//     throwIfDiagnostics: false,
//   );

//   final List<int> lineStarts = parseResult.lineInfo.lineStarts;
//   int prevIndex = 0;
//   int columnIndex = 0;
//   final List<int> matchIndexList = <int>[];

//   lineStarts.forEach((int lineStartIndex) {
//     if (lineStartIndex == 0) return;

//     final String lineStr = src.substring(prevIndex, lineStartIndex);
//     prevIndex = lineStartIndex;

//     final int findIndex = lineStr.indexOf(pattern);
//     if (findIndex != -1) {
//       matchIndexList.add(columnIndex);
//     }

//     columnIndex++;
//   });

// parseStringResult.unit.declarations.forEach((element) {
//   print('declarations element = ${element}');
// });

// parseStringResult.unit.directives.forEach((element) {
//   print('directives --element = ${element}');
// });

// for (final compilationUnit in parseStringResult.unit) {
//   print('^^^^^^^^compilationUnit = $compilationUnit');
//   // Don't analyze if there's no source; there's nothing to do.
//   if (compilationUnit.source == null) continue;
//   // Don't analyze generated source; there's nothing to do.
//   if (compilationUnit.source.fullName.endsWith('.g.dart')) continue;

//   for (final ClassElement type in compilationUnit.types) {
//     print('--checker type = $type');
//   }
// }

// for (final CompilationUnitElement compilationUnit in libraryElement.units) {
// Don't analyze if there's no source; there's nothing to do.
// if (compilationUnit.source == null) continue;
// Don't analyze generated source; there's nothing to do.
// if (compilationUnit.source.fullName.endsWith('.g.dart')) continue;

// for (final ClassElement type in compilationUnit.types) {
//   final PrioritizedSourceChange fix = PrioritizedSourceChange(
//     1000000,
//     SourceChange(
//       'YOOOOOOOOOOOOOOOO Apply fixes for neo.',
//       edits: <SourceFileEdit>[
//         SourceFileEdit(
//           '1111', // compilationUnit.source.fullName,
//           2222, //compilationUnit.source.modificationStamp,
//           edits: <SourceEdit>[SourceEdit(1, 2, 'test')], // edits,
//         )
//       ],
//     ),
//   );

//   final AnalysisError error = AnalysisError(
//     AnalysisErrorSeverity.WARNING,
//     AnalysisErrorType.LINT,
//     Location(
//       'hz', //compilationUnit.source.fullName,
//       666, //offset,
//       777, //length,
//       3, //offsetLineLocation.lineNumber,
//       4, //offsetLineLocation.columnNumber,
//       5,
//       6,
//     ),
//     'Class needs fixes for neo: ', // + '>>>', // errors.map((error) => error.message).join(' '),
//     'APP_NEO_NEEDS_FIXES________yoooo2222',
//     correction: 'correction message',
//     url: 'url hz',
//   );

//   result[error] = fix;
//   // }
//   // }

//   return result;
// }
// }

// import 'package:analyzer/dart/element/element.dart';
// // import 'package:analyzer/dart/element/type.dart';
// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:analyzer_plugin/protocol/protocol_generated.dart';

// class Checker {
//   Map<AnalysisError, PrioritizedSourceChange> check(LibraryElement libraryElement) {
//     final Map<AnalysisError, PrioritizedSourceChange> result = <AnalysisError, PrioritizedSourceChange>{};

//     // Element e;

//     print('checker **** libraryElement = $libraryElement');
//     for (final CompilationUnitElement compilationUnit in libraryElement.units) {
//       print('^^^^^^^^compilationUnit = $compilationUnit');
//       // Don't analyze if there's no source; there's nothing to do.
//       if (compilationUnit.source == null) continue;
//       // Don't analyze generated source; there's nothing to do.
//       if (compilationUnit.source.fullName.endsWith('.g.dart')) continue;

//       for (final ClassElement type in compilationUnit.types) {
//         print('--checker type = $type');
//       }
//     }

//     // for (final CompilationUnitElement compilationUnit in libraryElement.units) {
//     // Don't analyze if there's no source; there's nothing to do.
//     // if (compilationUnit.source == null) continue;
//     // Don't analyze generated source; there's nothing to do.
//     // if (compilationUnit.source.fullName.endsWith('.g.dart')) continue;

//     // for (final ClassElement type in compilationUnit.types) {
//     final PrioritizedSourceChange fix = PrioritizedSourceChange(
//       1000000,
//       SourceChange(
//         'YOOOOOOOOOOOOOOOO Apply fixes for neo.',
//         edits: <SourceFileEdit>[
//           SourceFileEdit(
//             '1111', // compilationUnit.source.fullName,
//             2222, //compilationUnit.source.modificationStamp,
//             edits: <SourceEdit>[SourceEdit(1, 2, 'test')], // edits,
//           )
//         ],
//       ),
//     );

//     final AnalysisError error = AnalysisError(
//       AnalysisErrorSeverity.ERROR,
//       AnalysisErrorType.LINT,
//       Location(
//         'hz', //compilationUnit.source.fullName,
//         666, //offset,
//         777, //length,
//         3, //offsetLineLocation.lineNumber,
//         4, //offsetLineLocation.columnNumber,
//         5,
//         6,
//       ),
//       'Class needs fixes for neo: ', // + '>>>', // errors.map((error) => error.message).join(' '),
//       'APP_NEO_NEEDS_FIXES________yoooo2222',
//     );

//     result[error] = fix;
//     // }
//     // }

//     return result;
//   }
// }

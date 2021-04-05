// import 'package:cool_linter/src/checker.dart';
// import 'package:test/test.dart';

// void main() {
//   const String twoColorsString = r'''
// import 'package:flutter/material.dart';

// class B {
//   void test() {
//     final t = Colors.accents;
//     final t2 = Colors.white;
//     final t2 = Color(0xFF123456);
//     final t3 = Color.fromARGB(1, 2, 3, 4);
//   }
// }
// ''';

//   const String twoColorsInOneLineString = r'''
// import 'package:flutter/material.dart';

// class B {
//   void test() {
//     final t = Colors.accents; final t2 = Colors.white;
//   }
// }
// ''';

//   const String noColorsString = r'''
// import 'package:flutter/material.dart';

// class B {
//   void test() {}
// }
// ''';

//   const String excludeCommentString = r'''
// import 'package:flutter/material.dart';

// class B {
//   // final t = Colors.accents;
//   void test() {}
//   /// final t2 = Colors.accents;
//   void test2() {}
// }
// ''';

//   group('find lines by patterns', () {
//     final RegExp colorsRegExp = RegExp(r'\sColors\.');
//     final Checker checker = Checker();

//     test('find two Colors', () async {
//       final List<IncorrectLineInfo> list = checker.getIncorrectLines(twoColorsString, colorsRegExp);

//       expect(list.length, 2);
//       expect(list[0], 4);
//       expect(list[1], 5);
//     });

//     test('find two Colors in one line', () async {
//       final List<int> list = checker.getIncorrectLines(twoColorsInOneLineString, colorsRegExp);

//       expect(list.length, 1);
//       expect(list[0], 4);
//     });

//     test('no Colors', () async {
//       final List<int> list = checker.getIncorrectLines(noColorsString, colorsRegExp);

//       expect(list, isEmpty);
//     });

//     test('exclude comments', () async {
//       final List<int> list = checker.getIncorrectLines(excludeCommentString, colorsRegExp);

//       expect(list, isEmpty);
//     });
//   });
// }

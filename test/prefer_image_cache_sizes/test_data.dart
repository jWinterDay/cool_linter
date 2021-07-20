// import 'package:flutter/widgets.dart';
final Image im1 = Image.asset(
  '',
  cacheWidth: 15,
  cacheHeight: 15,
  fit: BoxFit.cover,
);

final Image im2 = Image.asset(
  '',
  cacheWidth: 15,
  fit: BoxFit.cover,
);

final Image im3 = Image.asset(
  '',
  cacheHeight: 15,
  fit: BoxFit.cover,
);

final Image im4 = Image.asset(
  '',
  fit: BoxFit.cover,
);

final Center complexWidget1 = Center(
  child: Image.asset(
    '',
    fit: BoxFit.cover,
  ),
);

final Center complexWidget2 = Center(
  child: Image.asset(
    '',
    cacheWidth: 15,
    cacheHeight: 15,
    fit: BoxFit.cover,
  ),
);

// ============ custom classes
class TestImage {
  TestImage(
    this.name, {
    this.cacheHeight,
    this.cacheWidth,
  });

  final String name;
  final int? cacheWidth;
  final int? cacheHeight;
}

List<dynamic> someList = <dynamic>[
  TestImage('fdfds'), // LINT
  TestImage('fdfds', cacheHeight: 1), // LINT
  TestImage('fdfds', cacheWidth: 1), // LINT
  TestImage('fdfds', cacheHeight: 1, cacheWidth: 1), // OK
];

final t = TestImage('t');

class A {
  A(
    this.a,
    this.b, {
    required this.c,
    required this.d,
    required this.e,
    required this.ssss,
  });

  final int a;
  final int b;
  final int c;
  final int d;
  final int e;
  final String ssss;
}

// A some = A(1, 2, 3, 4,);

class B {
  // MUST BE LINT. currently not caught (length < 120 symbols)
  static A defA = A(16456, 253453454, c: 43242343, d: 4543544, e: 6666666, ssss: 'fdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsd');
}

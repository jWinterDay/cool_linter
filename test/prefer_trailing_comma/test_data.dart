// LINT
void firstFunction(
    String firstArgument, String secondArgument, String thirdArgument) {
  return;
}

void secondFunction() {
  firstFunction('some string', 'some other string',
      'and another string for length exceed'); // LINT
}

void thirdFunction(String someLongVarName, void Function() someLongCallbackName,
    String arg3) {} // LINT

class TestClass {
  // LINT
  void firstMethod(
      String firstArgument, String secondArgument, String thirdArgument) {
    return;
  }

  void secondMethod() {
    firstMethod('some string', 'some other string',
        'and another string for length exceed'); // LINT

    thirdFunction('some string', () {
      return;
    }, 'some other string'); // LINT
  }
}

enum FirstEnum {
  firstItem,
  secondItem,
  thirdItem,
  forthItem,
  fifthItem,
  sixthItem,
  f,
  fsd,
  fdgffhgfhf,
  gdgdf,
  bvcbcv,
  ytrytr,
  jg,
  asd,
  kjh
}

class FirstClass {
    // LINT
  const FirstClass(
      this.firstField, this.secondField, this.thirdField, this.forthField); // LINT

  final num firstField;
  final num secondField;
  final num thirdField;
  final num forthField;
}

const FirstClass instance =
    FirstClass(3.14159265359, 3.1415926456456465359, 3.14159265359, 3.1415926535945435345345345353453464575867867234234234);

final List<String> secondArray = <String>[
  'some string',
  'some other string',
  'and another string for length exceed'
];

final Set<String> secondSet = <String>{
  'some string',
  'some other string',
  'and another string for length exceed'
};

final Map<String, String> secondMap = <String, String>{
  'some string': 'and another string for length exceed',
  'and another string for length exceed': 'and another string for length exceed___________________________________________'
};

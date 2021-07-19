import 'dart:async';

final StreamSubscription<void> sub1 = Stream<void>.periodic(const Duration(seconds: 1), (_) {}).listen((_) {
  // OK
  // do nothing
});

class Test {
  Test() {
    Stream<int>.periodic(const Duration(seconds: 1)).listen((int i) {
      // LINT
      // do nothing
    });

    Stream<String>.value('value').listen((String val) {
      // LINT
      // do nothing
    });
  }
}

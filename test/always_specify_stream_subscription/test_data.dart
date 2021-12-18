import 'dart:async';

final StreamSubscription<void> sub1 =
    Stream<void>.periodic(const Duration(seconds: 1), (_) {})
        .listen((_) {}); // OK

class Test {
  Test() {
    // 5 warnings
    Stream<int>.periodic(const Duration(seconds: 1)).listen((int i) {}); // LINT

    Stream<String>.value('value').listen((String val) {}); // LINT

    StreamController<int> sc = StreamController<int>.broadcast();
    sc.stream.listen((int event) {}); // LINT

    StreamController<int> sc2 = StreamController<int>.broadcast()
      ..stream.listen((int event) {}); // LINT

    final Stream<String> stream1 = Stream<String>.value('value');
    stream1.listen((String ttt) {}); // LINT

    final Stream<String> stream2 = Stream<String>.value('value');
    final StreamSubscription<String> sub = stream2.listen((_) {}); // OK

    // 0 warnings
    StreamSubscription<bool> lateSub;
    lateSub = Stream<bool>.value(true).listen((_) {}); // OK
    lateSub.cancel();

    StreamSubscription<double> lateSub2 =
        Stream<double>.value(0.3).listen((_) {}); // OK
    lateSub2.cancel();

    StreamSubscription<bool> lateSubWithoutCancel =
        Stream<bool>.value(true).listen((_) {}); // OK

    // 1 warning
    Stream<String>.value('value').listen((String val) {}); // OK

    Stream<String>.value('value').listen((String val) {}); // LINT
  }
}

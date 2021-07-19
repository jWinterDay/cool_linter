import 'dart:async';

final StreamSubscription<void> sub1 = Stream<void>.periodic(const Duration(seconds: 1), (_) {}).listen((_) {}); // OK

class Test {
  Test() {
    Stream<int>.periodic(const Duration(seconds: 1)).listen((int i) {}); // LINT

    Stream<String>.value('value').listen((String val) {}); // LINT

    StreamController<int> sc = StreamController<int>.broadcast();
    sc.stream.listen((int event) {}); // LINT

    StreamController<int> sc2 = StreamController<int>.broadcast()..stream.listen((int event) {}); // LINT

    final Stream<String> stream1 = Stream<String>.value('value');
    stream1.listen((String ttt) {}); // LINT

    final Stream<String> stream2 = Stream<String>.value('value');
    final StreamSubscription<String> sub = stream2.listen((_) {}); // OK
  }
}

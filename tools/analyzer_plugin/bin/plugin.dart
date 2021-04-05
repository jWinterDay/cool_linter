import 'dart:isolate';

import 'package:cool_linter/cool_linter.dart';

void main(List<String> args, SendPort sendPort) {
  start(args, sendPort);
}

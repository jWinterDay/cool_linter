import 'dart:isolate';

import 'package:cool_linter/plugin_starter.dart';

void main(List<String> args, SendPort sendPort) {
  start(args, sendPort);
}

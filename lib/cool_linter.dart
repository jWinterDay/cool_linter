import 'dart:isolate';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/starter.dart';
import 'package:cool_linter/src/plugin.dart';

/// Start the analysis plugin
void start(List<String> args, SendPort sendPort) {
  ServerPluginStarter(
    CoolLinterPlugin(PhysicalResourceProvider.INSTANCE),
  ).start(sendPort);
}

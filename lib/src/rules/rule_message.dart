import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:meta/meta.dart';

@immutable
class RuleMessage {
  const RuleMessage({
    required this.severityName,
    required this.location,
    required this.code,
    required this.message,
    required this.changeMessage,
  });

  /// error
  final String severityName;

  /// error
  final Location location;

  /// error
  final String message;

  /// error
  final String code;

  /// fix
  final String changeMessage;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();

    sb.writeln('severityName: $severityName');
    sb.writeln('message: $message');
    sb.writeln('code: $code');
    sb.writeln('changeMessage: $changeMessage');
    sb.writeln('location: $location');

    return sb.toString();
  }
}

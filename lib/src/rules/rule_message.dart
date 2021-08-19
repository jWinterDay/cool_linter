import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:meta/meta.dart';

@immutable
class RuleMessage {
  const RuleMessage({
    this.severityName = 'INFO',
    required this.location,
    required this.code,
    required this.message,
    required this.changeMessage,
    this.addInfo,
    this.correction,
  });

  final String severityName;

  final Location location;

  final String message;

  final String code;

  final String? addInfo;

  /// fix info shown for user
  final String changeMessage;

  final String? correction;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();

    sb.writeln('severityName: $severityName');
    sb.writeln('message: $message');
    sb.writeln('code: $code');
    sb.writeln('changeMessage: $changeMessage');
    sb.writeln('location: $location');
    sb.writeln('correction: $correction');

    return sb.toString();
  }
}

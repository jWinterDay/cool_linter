import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:meta/meta.dart';

@immutable
class RuleMessage {
  const RuleMessage({
    this.severityName = 'INFO',
    required this.location,
    required this.code,
    required this.message,
    this.replacement,
    this.correction,
    this.addInfo,
  });

  final String severityName;

  final Location location;

  final String message;

  final String code;

  final String? replacement;

  /// fix info shown for user
  final String? correction;

  final String? addInfo;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();

    sb.writeln('severityName: $severityName');
    sb.writeln('message: $message');
    sb.writeln('code: $code');
    sb.writeln('correction: $correction');
    sb.writeln('location: $location');
    sb.writeln('correction: $correction');

    return sb.toString();
  }
}

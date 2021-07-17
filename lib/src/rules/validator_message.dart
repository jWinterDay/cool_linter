import 'package:meta/meta.dart';
import 'package:source_span/source_span.dart';

@immutable
class ValidatorMessage {
  const ValidatorMessage({
    required this.location,
    required this.message,
  });

  final SourceSpan location;

  final String message;

  // @override
  // String toString() {
  //   final StringBuffer sb = StringBuffer();

  //   sb.writeln('severityName: $severityName');
  //   sb.writeln('message: $message');
  //   sb.writeln('code: $code');
  //   sb.writeln('changeMessage: $changeMessage');
  //   sb.writeln('location: $location');

  //   return sb.toString();
  // }
}

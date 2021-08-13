import 'package:cool_linter/src/rules/rule_message.dart';

abstract class AnsiColors {
  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
  static const String reset = '\x1B[0m';

  static String prepareRuleForPrint(RuleMessage ruleMessage) {
    final StringBuffer sb = StringBuffer();

    sb.write(AnsiColors.red);
    sb.write(ruleMessage.message);
    sb.write(' ');

    sb.write(AnsiColors.green);
    sb.write(ruleMessage.location.file + ':');

    sb.write(AnsiColors.white);
    sb.write(ruleMessage.location.startLine);

    sb.write(AnsiColors.reset);

    return sb.toString();
  }
}

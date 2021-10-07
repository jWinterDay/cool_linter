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

  static String totalWarningsPrint(int count, {String addInfo = '', bool withColor = true}) {
    final StringBuffer sb = StringBuffer();

    if (withColor) sb.write(AnsiColors.cyan);
    sb.write('Total $addInfo: ');
    if (withColor) sb.write(AnsiColors.yellow);
    sb.write(count.toString());

    return sb.toString();
  }

  static void cliSettingsPrint(String name, Object? setting) {
    // ignore: avoid_print
    print('${AnsiColors.yellow}[$name]:${AnsiColors.white} ${setting?.toString()}${AnsiColors.reset}');
  }

  static String prepareRuleForPrint(RuleMessage ruleMessage, {bool withColor = true}) {
    final StringBuffer sb = StringBuffer();

    if (withColor) sb.write(AnsiColors.red);
    sb.write(ruleMessage.message);
    sb.write(' ');

    if (withColor) sb.write(AnsiColors.green);
    sb.write(ruleMessage.location.file + ':');

    if (withColor) sb.write(AnsiColors.white);
    sb.write(ruleMessage.location.endLine); // line
    sb.write(':');
    sb.write(ruleMessage.location.endColumn); // column
    // sb.write(' > ${ruleMessage.location}');

    if (withColor) sb.write(AnsiColors.reset);

    return sb.toString();
  }
}

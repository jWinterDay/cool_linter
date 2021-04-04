// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/ast/visitor.dart';
// import 'package:code_checker/checker.dart';
// import 'package:code_checker/rules.dart';

// const String _kDocumentationUrl = 'https://github.com/jWinterDay';
// const String _kFailure = 'Exclude words by rule';

// class ExcludeWordsRule extends Rule {
//   ExcludeWordsRule({
//     Map<String, Object> config = const <String, Object>{},
//   }) : super(
//           id: kRuleId,
//           documentation: Uri.parse(_kDocumentationUrl),
//           severity: readSeverity(config, Severity.warning),
//         );

//   static const String kRuleId = 'exclude_words';

//   @override
//   Iterable<Issue> check(ProcessedFile file) {
//     final _Visitor visitor = _Visitor();

//     file.parsedContent.visitChildren(visitor);

//     return visitor.arguments.map((Expression expression) {
//       return createIssue(
//         this,
//         nodeLocation(
//           node: expression,
//           source: file,
//           withCommentOrMetadata: true,
//         ),
//         _kFailure,
//         null,
//       );
//     }).toList(growable: false);
//   }
// }

// class _Visitor extends RecursiveAstVisitor<void> {
//   final _arguments = <Expression>[];

//   Iterable<Expression> get arguments => _arguments;

//   @override
//   void visitMethodInvocation(MethodInvocation node) {
//     super.visitMethodInvocation(node);

//     _visitArguments(node.argumentList.arguments);
//   }

//   @override
//   void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
//     super.visitFunctionExpressionInvocation(node);

//     _visitArguments(node.argumentList.arguments);
//   }

//   void _visitArguments(NodeList<Expression> arguments) {
//     for (final argument in arguments) {
//       final lastAppearance = arguments.lastWhere((arg) {
//         if (argument is NamedExpression &&
//             arg is NamedExpression &&
//             argument.expression is! Literal &&
//             arg.expression is! Literal) {
//           return argument.expression.toString() == arg.expression.toString();
//         }

//         if (_bothLiterals(argument, arg)) {
//           return argument == arg;
//         }

//         return argument.toString() == arg.toString();
//       });

//       if (argument != lastAppearance) {
//         _arguments.add(lastAppearance);
//       }
//     }
//   }

//   bool _bothLiterals(Expression left, Expression right) =>
//       left is Literal && right is Literal ||
//       (left is PrefixExpression && left.operand is Literal && right is PrefixExpression && right.operand is Literal);
//   // final List<NamedExpression> _expression = <NamedExpression>[];
//   // Iterable<NamedExpression> get expression => _expression;

//   // @override
//   // void visitAnnotation(Annotation node) {
//   //   if (node.name.name == 'Component' && node.atSign.type.lexeme == '@' && node.parent is ClassDeclaration) {
//   //     final NamedExpression preserveWhitespaceArg = node.arguments.arguments.whereType<NamedExpression>().firstWhere(
//   //       (NamedExpression arg) {
//   //         return arg.name.label.name == 'preserveWhitespace';
//   //       },
//   //       orElse: () {
//   //         return null;
//   //       },
//   //     );

//   //     if (preserveWhitespaceArg != null) {
//   //       final Expression expression = preserveWhitespaceArg.expression;
//   //       if (expression is BooleanLiteral && expression.literal.keyword == Keyword.FALSE) {
//   //         _expression.add(preserveWhitespaceArg);
//   //       }
//   //     }
//   //   }
//   // }
// }

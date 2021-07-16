import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, LinterContext, NodeLintRegistry, NodeLintRule;

import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

/// https://github.com/dart-lang/linter/blob/master/lib/src/rules/always_specify_types.dart

const String _desc = r'Specify type annotations.';

const String _details = r'''
From the [flutter style guide](https://flutter.dev/style-guide/):
**DO** specify type annotations.
Avoid `var` when specifying that a type is unknown and short-hands that elide
type annotations.  Use `dynamic` if you are being explicit that the type is
unknown.  Use `Object` if you are being explicit that you want an object that
implements `==` and `hashCode`.
**GOOD:**
```dart
int foo = 10;
final Bar bar = Bar();
String baz = 'hello';
const int quux = 20;
```
**BAD:**
```dart
var foo = 10;
final bar = Bar();
const quux = 20;
```
NOTE: Using the the `@optionalTypeArgs` annotation in the `meta` package, API
authors can special-case type variables whose type needs to by dynamic but whose
declaration should be treated as optional.  For example, suppose you have a
`Key` object whose type parameter you'd like to treat as optional.  Using the
`@optionalTypeArgs` would look like this:
```dart
import 'package:meta/meta.dart';
@optionalTypeArgs
class Key<T> {
 ...
}
main() {
  Key s = Key(); // OK!
}
```
''';

/// The name of `meta` library, used to define analysis annotations.
String _metaLibName = 'meta';

/// The name of the top-level variable used to mark a Class as having optional
/// type args.
String _optionalTypeArgsVarName = 'optionalTypeArgs';

bool _isOptionallyParameterized(TypeParameterizedElement element) {
  final List<ElementAnnotation> metadata = element.metadata;

  return metadata.any((ElementAnnotation a) => _isOptionalTypeArgs(a.element));
}

bool _isOptionalTypeArgs(Element? element) =>
    element is PropertyAccessorElement &&
    element.name == _optionalTypeArgsVarName &&
    element.library.name == _metaLibName;

class AlwaysSpecifyTypesRule extends LintRule implements NodeLintRule, Rule {
  AlwaysSpecifyTypesRule()
      : super(
          name: 'always_specify_types',
          description: _desc,
          details: _details,
          group: Group.style,
        );

  @override
  List<String> get incompatibleRules {
    return const <String>[
      'avoid_types_on_closure_parameters',
      'omit_local_variable_types',
    ];
  }

  // void registerNodeProcessors(NodeLintRegistry registry, LinterContext context) {
  //   var visitor = _Visitor(this);

  //   registry.addDeclaredIdentifier(this, visitor);
  //   registry.addListLiteral(this, visitor);
  //   registry.addSetOrMapLiteral(this, visitor);
  //   registry.addSimpleFormalParameter(this, visitor);
  //   registry.addTypeName(this, visitor);
  //   registry.addVariableDeclarationList(this, visitor);
  // }

  /// custom check
  @override
  List<RuleMessage> check({
    required ResolvedUnitResult parseResult,
    required YamlConfig yamlConfig,
  }) {
    final String? path = parseResult.path;
    if (path == null) {
      return <RuleMessage>[];
    }

    final _Visitor visitor = _Visitor(this);
    parseResult.unit?.visitChildren(visitor);

    //
    // visitor.rule
    //

    // return _visitor.missingInvocations
    //     .map((invocation) => createIssue(
    //           rule: this,
    //           location: nodeLocation(
    //             node: invocation,
    //             source: source,
    //           ),
    //           message: _warningMessage,
    //         ))
    //     .toList(growable: false);

    return <RuleMessage>[];
  }

  @override
  void registerNodeProcessors(NodeLintRegistry registry, LinterContext context) {
    print('-----registerNodeProcessors');
    final _Visitor visitor = _Visitor(this);

    registry.addDeclaredIdentifier(this, visitor);
    registry.addListLiteral(this, visitor);
    registry.addSetOrMapLiteral(this, visitor);
    registry.addSimpleFormalParameter(this, visitor);
    registry.addTypeName(this, visitor);
    registry.addVariableDeclarationList(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final Rule rule;

  // void checkLiteral(TypedLiteral literal) {
  //   if (literal.typeArguments == null) {
  //     rule.reportLintForToken(literal.beginToken);
  //   }
  // }

  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    print('-----visitDeclaredIdentifier');
    // if (node.type == null) {
    //   rule.reportLintForToken(node.keyword);
    // }
  }

  @override
  void visitListLiteral(ListLiteral literal) {
    print('-----visitListLiteral');
    // checkLiteral(literal);
  }

  void visitNamedType(NamedType namedType) {
    final DartType? type = namedType.type;

    if (type is InterfaceType) {
      final TypeParameterizedElement element = type.aliasElement ?? type.element;

      if (element.typeParameters.isNotEmpty &&
          namedType.typeArguments == null &&
          namedType.parent is! IsExpression &&
          !_isOptionallyParameterized(element)) {
        // TODO
        // rule.reportLint(namedType);
      }
    }
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral literal) {
    // TODO
    // checkLiteral(literal);
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter param) {
    final SimpleIdentifier? identifier = param.identifier;

    if (identifier != null && param.type == null) {
      //} && !isJustUnderscores(identifier.name)) {
      if (param.keyword != null) {
        // TODO
        // rule.reportLintForToken(param.keyword);
      } else {
        // TODO
        // rule.reportLint(param);
      }
    }
  }

  @override
  void visitTypeName(NamedType typeName) {
    visitNamedType(typeName);
  }

  @override
  void visitVariableDeclarationList(VariableDeclarationList list) {
    if (list.type == null) {
      // TODO
      // rule.reportLintForToken(list.keyword);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    super.visitMethodDeclaration(node);

    print('---visitMethodDeclaration');
  }
}

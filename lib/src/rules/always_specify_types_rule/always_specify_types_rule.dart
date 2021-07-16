import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:cool_linter/src/config/yaml_config.dart';
import 'package:analyzer/src/lint/linter.dart' show LintRule, Group, NodeLintRule;

import 'package:cool_linter/src/rules/rule.dart';
import 'package:cool_linter/src/rules/rule_message.dart';

/// https://github.com/dart-lang/linter/blob/master/lib/src/rules/always_specify_types.dart
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

final RegExp _underscores = RegExp(r'^[_]+$');
bool isJustUnderscores(String name) => _underscores.hasMatch(name);

class AlwaysSpecifyTypesRule extends LintRule implements NodeLintRule, Rule {
  AlwaysSpecifyTypesRule()
      : super(
          name: 'cool_linter_always_specify_types',
          description: 'cool_linter specify type annotations.',
          details: 'https://flutter.dev/style-guide',
          group: Group.style,
        );

  @override
  List<String> get incompatibleRules {
    return const <String>[
      'avoid_types_on_closure_parameters',
      'omit_local_variable_types',
    ];
  }

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

    print('after visit visitor = ${visitor.toString()}');

    return <RuleMessage>[];
  }

  // @override
  // void registerNodeProcessors(NodeLintRegistry registry, LinterContext context) {
  //   print('-----registerNodeProcessors');
  //   final _Visitor visitor = _Visitor(this);

  //   registry.addDeclaredIdentifier(this, visitor);
  //   registry.addListLiteral(this, visitor);
  //   registry.addSetOrMapLiteral(this, visitor);
  //   registry.addSimpleFormalParameter(this, visitor);
  //   registry.addTypeName(this, visitor);
  //   registry.addVariableDeclarationList(this, visitor);
  // }
}

class _Visitor extends RecursiveAstVisitor<void> {
  //} SimpleAstVisitor<void> {
  //} SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final Rule rule;

  void _checkLiteral(TypedLiteral literal) {
    if (literal.typeArguments == null) {
      print('++++ _checkLiteral: ${literal.typeArguments}');
    }
  }

  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    if (node.type == null) {
      print('++++ visitDeclaredIdentifier: ${node}');
    }
  }

  @override
  void visitListLiteral(ListLiteral literal) {
    _checkLiteral(literal);
  }

  void visitNamedType(NamedType namedType) {
    final DartType? type = namedType.type;

    if (type is InterfaceType) {
      final TypeParameterizedElement element = type.aliasElement ?? type.element;

      if (element.typeParameters.isNotEmpty &&
          namedType.typeArguments == null &&
          namedType.parent is! IsExpression &&
          !_isOptionallyParameterized(element)) {
        print('@@@@@@@@@ visitNamedType $namedType element = $element');
      }
    }
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral literal) {
    _checkLiteral(literal);
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter param) {
    final SimpleIdentifier? identifier = param.identifier;

    if (identifier != null && param.type == null && !isJustUnderscores(identifier.name)) {
      if (param.keyword != null) {
        print('&&&&& reportLintForToken $param');
      } else {
        print('====== reportLint $param ${param.identifier?.name}');
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
      print('----list = ${list.type} > ${list.keyword} > ${list}');
    }
  }

  @override
  void visitGenericFunctionType(GenericFunctionType node) {
    print('visitGenericFunctionType $node');
  }

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    print('visitGenericTypeAlias $node');
  }
}

import 'package:_fe_analyzer_shared/src/scanner/token.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'always_specify_types_result.dart';

//
import 'dart:async';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:built_collection/built_collection.dart';

import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
//

/// https://github.com/dart-lang/linter/blob/master/lib/src/rules/always_specify_types.dart
/// The name of `meta` library, used to define analysis annotations.
String _metaLibName = 'meta';

/// The name of the top-level variable used to mark a Class as having optional type args.
String _optionalTypeArgsVarName = 'optionalTypeArgs';

bool _isOptionallyParameterized(TypeParameterizedElement element) {
  final List<ElementAnnotation> metadata = element.metadata;

  return metadata.any((ElementAnnotation a) => _isOptionalTypeArgs(a.element));
}

bool _isOptionalTypeArgs(Element? element) {
  return element is PropertyAccessorElement &&
      element.name == _optionalTypeArgsVarName &&
      element.library.name == _metaLibName;
}

final RegExp _underscores = RegExp(r'^[_]+$');
bool isJustUnderscores(String name) => _underscores.hasMatch(name);

class AlwaysSpecifyTypesVisitor extends RecursiveAstVisitor<void> {
  AlwaysSpecifyTypesVisitor(
    this.rule, {
    required this.useDeclaredIdentifier,
    required this.useSetOrMapLiteral,
    required this.useSimpleFormalParameter,
    required this.useTypeName,
    required this.useTypedLiteral,
    required this.useVariableDeclarationList,
  });

  final Rule rule;

  final bool useTypedLiteral;
  final bool useDeclaredIdentifier;
  final bool useSetOrMapLiteral;
  final bool useSimpleFormalParameter;
  final bool useTypeName;
  final bool useVariableDeclarationList;

  final List<AlwaysSpecifyTypesResult> _visitorRuleMessages = <AlwaysSpecifyTypesResult>[];
  List<AlwaysSpecifyTypesResult> get visitorRuleMessages => _visitorRuleMessages;

  void _checkLiteral(TypedLiteral literal) {
    if (literal.typeArguments == null) {
      _visitorRuleMessages.add(
        AlwaysSpecifyTypesResult.withType(
          astNode: literal,
          type: ResultType.typedLiteral,
        ),
      );
      // print('((((++++)))) _checkLiteral: ${literal} | ${literal.parent} ${literal.typeArguments}');
    }
  }

  // @override
  // void visitMethodDeclaration(MethodDeclaration node) {
  //   super.visitMethodDeclaration(node);

  //   print('[#####################] visitMethodDeclaration: ${node}');
  // }

  // ---
  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    super.visitDeclaredIdentifier(node);

    if (!useDeclaredIdentifier) return;

    if (node.type == null) {
      // correction
      final SimpleIdentifier? identifier = node.identifier;
      final String? varType = node.declaredElement?.type.getDisplayString(withNullability: true);

      String? corr;
      if (identifier != null && varType != 'dynamic') {
        final StringBuffer sb = StringBuffer()
          ..write(varType)
          ..write(' ')
          ..write(identifier.name);

        corr = sb.toString();

        // final Token? keyword = node.keyword;
        // print('lexeme = ${keyword?.stringValue} len = ${identifier.length} name = ${identifier.name} type = $varType');
      }

      _visitorRuleMessages.add(
        AlwaysSpecifyTypesResult.withType(
          astNode: node,
          type: ResultType.declaredIdentifier,
          correction: corr,
        ),
      );
      // print('++++ visitDeclaredIdentifier: ${node}');
    }
  }

  // ---
  @override
  void visitListLiteral(ListLiteral node) {
    super.visitListLiteral(node);

    if (!useTypedLiteral) return;

    _checkLiteral(node);
  }

  void _visitNamedType(TypeName node) {
    final DartType? type = node.type;

    if (type is InterfaceType) {
      final TypeParameterizedElement element = type.aliasElement ?? type.element;

      if (element.typeParameters.isNotEmpty &&
          node.typeArguments == null &&
          node.parent is! IsExpression &&
          !_isOptionallyParameterized(element)) {
        _visitorRuleMessages.add(
          AlwaysSpecifyTypesResult.withType(
            astNode: node,
            type: ResultType.typeName,
          ),
        );
        // print('@@@@@@@@@ _visitNamedType $namedType element = $element');
      }
    }
  }

  // ---
  @override
  void visitSetOrMapLiteral(SetOrMapLiteral node) {
    super.visitSetOrMapLiteral(node);

    if (!useSetOrMapLiteral) return;

    _checkLiteral(node);
  }

  // ---
  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    super.visitSimpleFormalParameter(node);

    if (!useSimpleFormalParameter) return;

    final SimpleIdentifier? identifier = node.identifier;

    if (identifier != null && node.type == null && !isJustUnderscores(identifier.name)) {
      // correction
      final String? varType = node.declaredElement?.type.getDisplayString(withNullability: true);

      String? corr;
      if (varType != 'dynamic') {
        final StringBuffer sb = StringBuffer()
          ..write(varType)
          ..write(' ')
          ..write(identifier.name);

        corr = sb.toString();

        // final Token? keyword = node.keyword;
        // print('lexeme = ${keyword?.stringValue} len = ${identifier.length} name = ${identifier.name} type = $varType');
      }

      _visitorRuleMessages.add(
        AlwaysSpecifyTypesResult.withType(
          astNode: node,
          type: ResultType.simpleFormalParameter,
          correction: corr,
        ),
      );
    }
  }

  // ---
  @override
  void visitTypeName(TypeName node) {
    super.visitTypeName(node);

    if (!useTypeName) return;

    _visitNamedType(node);
  }

  // ---
  @override
  void visitVariableDeclarationList(VariableDeclarationList node) {
    super.visitVariableDeclarationList(node);

    if (!useVariableDeclarationList) return;

    if (node.type == null) {
      _visitorRuleMessages.add(
        AlwaysSpecifyTypesResult.withType(
          astNode: node,
          type: ResultType.variableDeclarationList,
        ),
      );

      // print('----list = ${list.type} > ${list.keyword} > ${list}');
    }
  }

  // @override
  // void visitGenericFunctionType(GenericFunctionType node) {
  //   super.visitGenericFunctionType(node);

  //   print('visitGenericFunctionType $node');
  // }

  // @override
  // void visitGenericTypeAlias(GenericTypeAlias node) {
  //   super.visitGenericTypeAlias(node);

  //   print('visitGenericTypeAlias $node');
  // }

  // @override
  // void visitVariableDeclaration(VariableDeclaration node) {
  //   super.visitVariableDeclaration(node);

  //   print('[FFFFFFFF] visitVariableDeclaration $node');
  // }
}

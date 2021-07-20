import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'package:cool_linter/src/rules/rule.dart';

import 'prefer_image_cache_sizes_result.dart';

class PreferImageCacheSizesVisitor extends RecursiveAstVisitor<void> {
  PreferImageCacheSizesVisitor(this.rule);

  final Rule rule;

  final List<PreferImageCacheSizesResult> _visitorRuleMessages = <PreferImageCacheSizesResult>[];
  List<PreferImageCacheSizesResult> get visitorRuleMessages => _visitorRuleMessages;

  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    super.visitDeclaredIdentifier(node);

    if (node.type == null) {
      _visitorRuleMessages.add(PreferImageCacheSizesResult(
        astNode: node,
      ));
      // print('++++ visitDeclaredIdentifier: ${node}');
    }
  }
}

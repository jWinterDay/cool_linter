import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type_provider.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/source/line_info.dart';

class MockResolvedUnitResult extends ResolvedUnitResult {
  @override
  String get content => throw UnimplementedError();
  @override
  List<AnalysisError> get errors => throw UnimplementedError();
  @override
  bool get exists => throw UnimplementedError();
  @override
  bool get isPart => throw UnimplementedError();
  @override
  LibraryElement get libraryElement => throw UnimplementedError();
  @override
  LineInfo get lineInfo => throw UnimplementedError();
  @override
  String get path => '';
  @override
  AnalysisSession get session => throw UnimplementedError();
  @override
  // ignore: deprecated_member_use
  // ResultState get state => throw UnimplementedError();
  @override
  TypeProvider get typeProvider => throw UnimplementedError();
  @override
  TypeSystem get typeSystem => throw UnimplementedError();
  @override
  CompilationUnit get unit => throw UnimplementedError();
  @override
  Uri get uri => throw UnimplementedError();
}

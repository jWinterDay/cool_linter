import 'dart:convert';

import 'package:yaml/yaml.dart';

Map<String, dynamic> convertYamlToMap(String str) {
  final dynamic rawMap = json.decode(json.encode(loadYaml(str)));
  if (rawMap is! Map<String, dynamic>) {
    throw ArgumentError('Wrong yaml source');
  }

  return rawMap;
}

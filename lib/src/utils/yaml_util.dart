import 'package:yaml/yaml.dart';

List<Object> yamlListToDartList(YamlList map) {
  return List<Object>.unmodifiable(map.nodes.map<Object>(yamlNodeToDartObject));
}

Map<String, Object> yamlMapToDartMap(YamlMap map) {
  return Map<String, Object>.unmodifiable(
    Map<String, Object>.fromEntries(
      map.nodes.keys.whereType<YamlScalar>().where((YamlScalar key) {
        return key.value is String;
      }).map(
        (YamlScalar key) {
          return MapEntry<String, Object>(
            key.value.toString(),
            yamlNodeToDartObject(map.nodes[key]),
          );
        },
      ),
    ),
  );
}

Object yamlNodeToDartObject(YamlNode node) {
  if (node is YamlMap) {
    return yamlMapToDartMap(node);
  } else if (node is YamlList) {
    return yamlListToDartList(node);
  } else if (node is YamlScalar) {
    return yamlScalarToDartObject(node);
  }

  return Object();
}

Object yamlScalarToDartObject(YamlScalar scalar) {
  // ignore: avoid_as
  return scalar.value as Object;
}

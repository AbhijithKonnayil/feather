import 'package:feather_core/src/models/file_meta.dart' show FileMeta;

enum WidgetType { block, ui }

class WidgetMeta {
  const WidgetMeta({
    required this.name,
    required this.description,
    required this.type,
    required this.files,
    this.dependencies = const [],
    this.registryDependencies = const [],
  });
  final String name;
  final String description;
  final WidgetType type;
  final List<String> dependencies;
  final List<String> registryDependencies;
  final List<FileMeta> files;

  dynamic toJson() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'dependencies': dependencies,
      'registryDependencies': registryDependencies,
      'files': files.map((file) => file.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

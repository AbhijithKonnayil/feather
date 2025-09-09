import 'package:feather_core/src/core/enum.dart';
import 'package:feather_core/src/models/file_meta.dart' show FileMeta;

enum WidgetType { block, ui }

class WidgetMeta {
  const WidgetMeta({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.files,
    this.dependencies = const [],
    this.registryDependencies = const [],
    this.widgetCategories = const [],
    this.widgetGroups = const [],
  });
  final String id;
  final String name;
  final String description;
  final WidgetType type;
  final List<String> dependencies;
  final List<String> registryDependencies;
  final List<FileMeta> files;
  final List<WidgetComponent> widgetCategories;
  final List<WidgetGroup> widgetGroups;

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

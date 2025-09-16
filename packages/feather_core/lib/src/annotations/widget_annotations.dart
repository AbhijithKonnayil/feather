import 'package:feather_core/src/core/enum.dart';
import 'package:feather_core/src/core/widget_categories.dart';
import 'package:feather_core/src/core/widget_scope.dart';
import 'package:feather_core/src/core/widget_types.dart';
import 'package:feather_core/src/models/file_meta.dart';

abstract class WidgetMeta<T extends WidgetType, C extends WidgetCategory> {
  const WidgetMeta({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.files,
    required this.screens,
    this.dependencies = const [],
    this.registryDependencies = const [],
    required this.types,
    this.categories = const [],
  });
  final String id;
  final String name;
  final String description;
  final WidgetScope type;
  final List<String> dependencies;
  final List<String> registryDependencies;
  final List<FileMeta> files;
  final List<T> types;
  final List<C> categories;
  final List<Screens> screens;

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

class PageMeta extends WidgetMeta<PageType, PageCategory> {
  const PageMeta({
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.files,
    required super.types,
    required super.categories,
    required super.screens,
  });
}

class BlockMeta extends WidgetMeta<BlockType, BlockCategory> {
  const BlockMeta({
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.files,
    required super.types,
    required super.categories,
    required super.screens,
  });
}

class ComponentMeta extends WidgetMeta<ComponentType, ComponentCategory> {
  const ComponentMeta({
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.files,
    required super.types,
    required super.categories,
    required super.screens,
  });
}

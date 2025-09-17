import 'package:feather_core/src/core/enums/enum.dart';
import 'package:feather_core/src/models/file_meta.dart';

abstract class WidgetMeta<T extends WidgetType, C extends WidgetCategory> {
  const WidgetMeta({
    required this.id,
    required this.name,
    required this.description,
    required this.scope,
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
  final WidgetScope scope;
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
      'type': scope,
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
    required super.files,
    required super.types,
    required super.categories,
    required super.screens,
  }) : super(scope: WidgetScope.page);
}

class BlockMeta extends WidgetMeta<BlockType, BlockCategory> {
  const BlockMeta({
    required super.id,
    required super.name,
    required super.description,
    required super.files,
    required super.types,
    required super.categories,
    required super.screens,
  }) : super(scope: WidgetScope.block);
}

class ComponentMeta extends WidgetMeta<ComponentType, ComponentCategory> {
  const ComponentMeta({
    required super.id,
    required super.name,
    required super.description,
    required super.files,
    required super.types,
    required super.categories,
    required super.screens,
  }) : super(scope: WidgetScope.component);
}

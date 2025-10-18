import 'package:feather_core/src/core/enums/enum.dart';
import 'package:feather_core/src/models/file_meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'widget_annotations.g.dart';

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
  @WidgetTypeConverter()
  final List<T> types;
  @WidgetTypeConverter()
  final List<C> categories;
  @WidgetTypeConverter()
  final List<Screens> screens;

  static WidgetMeta fromJson(Map<String, dynamic> json) {
    final scope = json['scope'] as String?;

    switch (scope) {
      case 'page':
        return PageMeta.fromJson(json);
      case 'block':
        return BlockMeta.fromJson(json);
      case 'component':
        return ComponentMeta.fromJson(json);
      default:
        throw Exception('Unknown WidgetMeta type: $scope');
    }
  }

  Map<String, dynamic> toJson() {
    switch (scope) {
      case WidgetScope.component:
        return (this as ComponentMeta).toJson();
      case WidgetScope.block:
        return (this as BlockMeta).toJson();
      case WidgetScope.page:
        return (this as PageMeta).toJson();
    }
  }
}

@JsonSerializable()
class PageMeta extends WidgetMeta<PageType, PageCategory> {
  const PageMeta({
    required super.id,
    required super.name,
    required super.description,
    super.files = const [],
    required super.types,
    required super.categories,
    required super.screens,
  }) : super(scope: WidgetScope.page);

  factory PageMeta.fromJson(Map<String, dynamic> json) =>
      _$PageMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PageMetaToJson(this);
}

@JsonSerializable()
class BlockMeta extends WidgetMeta<BlockType, BlockCategory> {
  const BlockMeta({
    required super.id,
    required super.name,
    required super.description,
    super.files = const [],
    required super.types,
    required super.categories,
    required super.screens,
  }) : super(scope: WidgetScope.block);

  factory BlockMeta.fromJson(Map<String, dynamic> json) =>
      _$BlockMetaFromJson(json);

  Map<String, dynamic> toJson() => _$BlockMetaToJson(this);
}

@JsonSerializable()
class ComponentMeta extends WidgetMeta<ComponentType, ComponentCategory> {
  const ComponentMeta({
    required super.id,
    required super.name,
    required super.description,
    super.files = const [],
    required super.types,
    required super.categories,
    required super.screens,
  }) : super(scope: WidgetScope.component);

  factory ComponentMeta.fromJson(Map<String, dynamic> json) =>
      _$ComponentMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentMetaToJson(this);
}

class WidgetTypeConverter<T extends LabeledEnum>
    implements JsonConverter<T, String> {
  const WidgetTypeConverter();

  @override
  T fromJson(String json) {
    print("JSON $json ");
    if (T == ComponentType) {
      return ComponentType.values.byName(json) as T;
    } else if (T == BlockType) {
      return BlockType.values.byName(json) as T;
    } else if (T == PageType) {
      return PageType.values.byName(json) as T;
    }
    throw Exception('Unknown type $T');
  }

  @override
  String toJson(T object) {
    return object.toString().split('.').last;
  }
}

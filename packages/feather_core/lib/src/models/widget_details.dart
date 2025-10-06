import 'package:feather_core/src/annotations/widget_annotations.dart';

class WidgetDetails extends WidgetMeta {
  WidgetDetails({
    required super.id,
    required super.name,
    required super.description,
    required super.scope,
    required super.files,
    required super.types,
    required super.categories,
    required this.example,
    required super.screens,
  });
  final dynamic Function() example;
  String get installCommand => 'feather add -s ${scope.name} $id';
}

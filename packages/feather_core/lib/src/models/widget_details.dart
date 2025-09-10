import 'package:feather_core/feather_core.dart' show WidgetMeta;

class WidgetDetails extends WidgetMeta {
  ///Do Not use `Widget` as type
  ///the VM compiler cannot resolve Flutter types
  ///Flutter depends on dart:ui, which only works in Flutter runtime,
  ///not plain Dart VM
  final dynamic Function() example;
  WidgetDetails({
    required this.example,
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.files,
    required super.widgetCategories,
  });

  String get installCommand => 'feather add $id';
}

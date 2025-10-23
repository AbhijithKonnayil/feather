import 'package:feather_core/feather_core.dart';

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
  String getScreenshotFilename(Screens screen) => "${id}_${screen.name}.jpeg";
  String getScreenshotPath(Screens screen) =>
      "assets/screenshots/${scope.name}/${getScreenshotFilename(screen)}";
}

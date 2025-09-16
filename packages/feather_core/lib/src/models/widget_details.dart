import 'package:feather_core/src/annotations/widget_annotations.dart';

class ComponentDetails extends ComponentMeta {
  ComponentDetails({
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.files,
    required super.types,
    required super.categories,
    required this.example,
    required super.screens,
  });
  final dynamic Function() example;
  String get installCommand => 'feather add $id';
}

/* 
class WidgetDetails extends ComponentDetails<WidgetCategory> {
  ///Do Not use `Widget` as type
  ///the VM compiler cannot resolve Flutter types
  ///Flutter depends on dart:ui, which only works in Flutter runtime,
  ///not plain Dart VM
  WidgetDetails({
    required super.example,
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.files,
    required super.types,
    required super.categories,
  });
}

class PageDetails extends ComponentDetails<PageCategory> {
  ///Do Not use `Widget` as type
  ///the VM compiler cannot resolve Flutter types
  ///Flutter depends on dart:ui, which only works in Flutter runtime,
  ///not plain Dart VM

  PageDetails({
    required super.example,
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.files,
    required super.types,
    required super.categories,
  }); 
}
*/

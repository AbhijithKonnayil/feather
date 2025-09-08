import 'package:feather_ui/feather_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
// Import the widget from your app

@widgetbook.UseCase(name: 'Default', type:FeatherButton )
Widget buildCoolButtonUseCase(BuildContext context) {
  return FeatherButton();
}

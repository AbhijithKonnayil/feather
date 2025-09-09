import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: [],
      integrations: [],
      addons: [
        ViewportAddon([AndroidViewports.onePlus8Pro]),
      ],
      appBuilder: (context, child) {
        return Center(child: child);
      },
    );
  }
}

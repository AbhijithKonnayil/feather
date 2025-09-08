import 'package:catalog/catalog/catelog_page.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(MaterialApp(home: const CatalogPage()));
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: directories,
      integrations: [],
      addons: [
        ViewportAddon([AndroidViewports.onePlus8Pro]),
      ],
      appBuilder: (context, child) {
        return Container(child: Center(child: child));
      },
    );
  }
}

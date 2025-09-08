// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:catalog/button.dart' as _catalog_button;
import 'package:catalog/widgets/feather_text_box.dart'
    as _catalog_widgets_feather_text_box;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'wig',
    children: [
      _widgetbook.WidgetbookLeafComponent(
        name: 'FeatherButton',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _catalog_button.buildCoolButtonUseCase,
        ),
      ),
      _widgetbook.WidgetbookComponent(
        name: 'FeatherTextBox',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Primary',
            builder: _catalog_widgets_feather_text_box.useCaseFeatherTextBox1,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'default',
            builder: _catalog_widgets_feather_text_box.useCaseFeatherTextBox,
          ),
        ],
      ),
    ],
  ),
];

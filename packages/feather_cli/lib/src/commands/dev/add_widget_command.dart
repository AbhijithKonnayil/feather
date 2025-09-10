import 'dart:async';
import 'dart:io';

import 'package:change_case/change_case.dart';
import 'package:feather_cli/src/core/command.dart';
import 'package:feather_cli/src/utils/file_utils.dart';
import 'package:mason_logger/mason_logger.dart';

class AddWidgetCommand extends FCommand {
  /// {@macro sample_command}
  AddWidgetCommand({required Logger logger}) : _logger = logger;

  @override
  String get description => 'Create boilerplate for a new widget in feather_ui';

  @override
  String get name => 'add_widget';

  final Logger _logger;

  /// Reads the registry.json file and returns it as a Map

  @override
  Future<int> execute() async {
    // Get the parameter passed to the add command (first positional argument)
    final args = argResults?.rest ?? [];

    final widgetName = _logger
        .prompt(
          'Enter the widget name (e.g. FancyButton)',
        )
        .toPascalCase();
    final widgetId = _logger
        .prompt(
          'Enter a unique widget id (e.g. fancy_btn)',
        )
        .toPascalCase();
    final fileName = widgetName.toSnakeCase();
    final featherUiRoot = FileUtils.findProjectRoot(Directory.current);

    final widgetFilePath = 'lib/widgets/$fileName/$fileName.dart';
    final exampleFilePath = 'lib/widgets/$fileName/$fileName.example.dart';

    await Future.wait([
      FileUtils.createFile(
        widgetFilePath,
        createWidgetFileContent(
          fileName: fileName,
          widgetName: widgetName,
          widgetId: widgetId,
        ),
      ),
      FileUtils.createFile(
        exampleFilePath,
        createExampleFileContent(fileName: fileName, widgetName: widgetName),
      ),
    ]);

    return ExitCode.success.code;
  }

  String createWidgetFileContent({
    required String widgetName,
    required String fileName,
    required String widgetId,
  }) {
    final buffer = StringBuffer()
      ..write('''
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';

part '$fileName.example.dart';
@WidgetMeta(
  id: '$widgetId',
  name: 'Feather Button 123',
  description: 'A simple Feather Button for demo',
  type: WidgetType.ui,
  files: [],
  //TODO: add catagories
  widgetCategories: ,
)
class $widgetName extends StatelessWidget {

 const $widgetName({super.key});

 @override
  Widget build(BuildContext context) {
  return Placeholder();
  }

}
''');
    return buffer.toString();
  }

  String createExampleFileContent({
    required String widgetName,
    required String fileName,
  }) {
    final buffer = StringBuffer()
      ..write('''
part of '$fileName.dart';

Widget buildExampleWidget() {
  return $widgetName();
}

''');

    return buffer.toString();
  }

  @override
  FutureOr<bool> validate() {
    return FileUtils.isInsidePackage("feather_ui");
  }
}

import 'dart:async';

import 'package:change_case/change_case.dart';
import 'package:feather_cli/src/core/command.dart';
import 'package:feather_core/feather_core.dart';

class AddWidgetCommand extends FCommand {
  /// {@macro sample_command}
  AddWidgetCommand({required FConsoleLogger logger}) : _logger = logger {
    argParser.addOption(
      'scope',
      abbr: 's',
      help: 'Type of widget to add (component, block, page)',
      allowed: ['component', 'block', 'page'],
      mandatory: true,
    );
  }

  @override
  String get description => 'Create boilerplate for a new widget in feather_ui';

  @override
  String get name => 'add_widget';

  final FConsoleLogger _logger;

  /// Reads the registry.json file and returns it as a Map

  @override
  Future<int> execute() async {
    // Get the parameter passed to the add command (first positional argument)
    final type = (argResults?['scope'] as String).toLowerCase();

    final widgetName = _logger
        .prompt(
          'Enter the widget name (e.g. FancyButton)',
        )
        .toPascalCase();
    final widgetId = _logger
        .prompt(
          'Enter a unique widget id (e.g. fancy_btn)',
        )
        .toSnakeCase();
    final fileName = widgetId.toSnakeCase();
    //final featherUiRoot = FileUtils.findProjectRoot(Directory.current);

    final widgetFilePath = 'lib/$type/$fileName/$fileName.dart';
    final exampleFilePath = 'lib/$type/$fileName/$fileName.example.dart';

    await Future.wait([
      FileUtils.createFile(
        widgetFilePath,
        createWidgetFileContent(
          fileName: fileName,
          widgetName: widgetName,
          widgetId: widgetId,
          type: type,
        ),
      ),
      FileUtils.createFile(
        exampleFilePath,
        createExampleFileContent(
          fileName: fileName,
          widgetName: widgetName,
          widgetId: widgetId,
        ),
      ),
    ]);

    return ExitCode.success.code;
  }

  String createWidgetFileContent({
    required String widgetName,
    required String fileName,
    required String widgetId,
    required String type,
  }) {
    final annotation = '${type}Meta'.toPascalCase();
    final buffer = StringBuffer()
      ..write('''
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';

part '$fileName.example.dart';

@$annotation(
  id: '$widgetId',
  name: '${widgetName.toCapitalCase()}',
  description: 'A simple $widgetName component for demo',
  files: [],
  //TODO: add screen types
  screens:,
  //TODO: add types
  types:,
  //TODO: add categories
  categories: ,
)
class $widgetName extends StatelessWidget {

 const $widgetName({super.key});

 @override
  Widget build(BuildContext context) {
   return Container(
      child: Text("$widgetName"),
    );
  }

}
''');
    return buffer.toString();
  }

  String createExampleFileContent({
    required String widgetName,
    required String fileName,
    required String widgetId,
  }) {
    final buffer = StringBuffer()
      ..write('''
part of '$fileName.dart';

Widget buildExampleWidgetFor_$widgetId() {
  return $widgetName();
}

''');

    return buffer.toString();
  }

  @override
  FutureOr<bool> validate() {
    return FileUtils.isInsidePackage('feather_ui');
  }
}

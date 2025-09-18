import 'package:args/command_runner.dart';
import 'package:feather_cli/src/commands/dev/add_widget_command.dart';
import 'package:feather_cli/src/commands/dev/screenshot_widget.dart';
import 'package:mason_logger/mason_logger.dart';

class DevCommand extends Command<int> {
  DevCommand({required Logger logger}) {
    _logger = logger;
    addSubcommand(AddWidgetCommand(logger: _logger));
    addSubcommand(ScreenshotWidgetCommand(logger: _logger));
  }
  @override
  final name = 'dev';
  @override
  final description = 'Contributor tools for Feather development';

  late Logger _logger;
}

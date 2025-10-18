import 'dart:async';
import 'dart:io';

import 'package:feather_cli/src/core/command.dart';
import 'package:feather_core/feather_core.dart';

class ScreenshotWidgetCommand extends FCommand {
  /// {@macro sample_command}
  ScreenshotWidgetCommand({required FConsoleLogger logger}) : _logger = logger {
    argParser
      ..addOption(
        'scope',
        abbr: 's',
        help: 'Type of widget to take screenshot (component, block, page)',
        allowed: ['component', 'block', 'page'],
        mandatory: true,
      )
      ..addOption(
        'widget_id',
        abbr: 'i',
        help: 'ID of widget to take screenshot',
        mandatory: true,
      );
  }

  @override
  String get description => 'Create boilerplate for a new widget in feather_ui';

  @override
  String get name => 'screenshot_widget';

  final FConsoleLogger _logger;

  /// Reads the registry.json file and returns it as a Map

  @override
  Future<int> execute() async {
    late String device;
    if (Platform.isLinux) {
      device = 'linux';
    } else if (Platform.isMacOS) {
      device = 'macos';
    } else if (Platform.isWindows) {
      device = 'windows';
    } else {
      stderr.writeln('❌ Unsupported platform: ${Platform.operatingSystem}');
      exit(1);
    }
    final widget = argResults?['widget_id'] as String;
    final scope = argResults?['scope'] as String;

    final root = FileUtils.findProjectRoot(Directory.current);
    if (root == null) {
      throw InvalidDirectoryException('This must be used in `Feather Repo`');
    }
    final catalogDir = Directory('${root.path}/packages/catalog_website');
    if (!catalogDir.existsSync()) {
      stderr.writeln('❌ packages/catalog_website not found.');
      exit(1);
    }
    final result = await Process.start(
      'flutter',
      [
        'run',
        '-d',
        device,
        '-t',
        'lib/tools/screenshot.dart',
        '-a',
        scope,
        '-a',
        widget,
      ],
      workingDirectory: catalogDir.path,
      mode: ProcessStartMode.inheritStdio,
    );

    return result.exitCode;
  }

  @override
  FutureOr<bool> validate() {
    return FileUtils.isInsidePackage('catalog_website');
  }
}

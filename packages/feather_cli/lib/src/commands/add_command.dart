import 'dart:async';
import 'dart:io';

import 'package:feather_cli/src/core/command.dart';
import 'package:feather_cli/src/core/http_client.dart';
import 'package:feather_core/feather_core.dart';

class AddCommand extends FCommand {
  AddCommand({required FConsoleLogger logger}) : _logger = logger {
    argParser.addOption(
      'scope',
      abbr: 's',
      help: 'Type of widget to add (component, block, page)',
      allowed: ['component', 'block', 'page'],
      mandatory: true,
    );
  }

  @override
  String get description => 'Add a widget to your project';

  @override
  String get name => 'add';

  final FConsoleLogger _logger;
  final FHttpClient httpClient = FHttpClient();
  WidgetScope? widgetScope;
  String? widgetName;

  Future<Map<String, dynamic>> getRegistry() async {
    try {
      final data = await httpClient.get(
        'https://raw.githubusercontent.com/AbhijithKonnayil/feather/refs/heads/main/packages/feather_registry/lib/widget_meta/${widgetScope!.name}.g.json',
      );
      if (data == null) {
        throw FException('Failed to fetch registry');
      }
      return data as Map<String, dynamic>;
    } on HttpException catch (e) {
      _logger.error(e.message);
      throw FException('Failed to fetch registry');
    } on Exception catch (e) {
      _logger.error(e.toString());
      throw FException('Failed to fetch registry');
    }
  }

  Future<WidgetMeta> getWidgetMeta(String widgetName) async {
    final registryJson = await getRegistry();

    final widgetJson = registryJson[widgetName];
    if (widgetJson == null) {
      throw FException('$widgetName not found in registry');
    }
    return WidgetMeta.fromJson(widgetJson as Map<String, dynamic>);
  }

  void installDependency(WidgetMeta widgetMeta) {
    _runProcessAndLog('dart', ['pub', 'add', ...widgetMeta.dependencies]);
  }

  Future<void> downloadFiles(WidgetMeta widgetMeta) async {
    await Future.wait(
      widgetMeta.files.map(
        (e) => httpClient.downloadFile(e.absolutePath(), e.path),
      ),
    );
  }

  void _runProcessAndLog(String executable, List<String> arguments) {
    final result = Process.runSync(executable, arguments);
    if (result.stdout != null && result.stdout.toString().isNotEmpty) {
      _logger.info(result.stdout.toString());
    }
    if (result.stderr != null && result.stderr.toString().isNotEmpty) {
      _logger.error(result.stderr.toString());
    }
    if (result.exitCode != 0) {
      _logger.error('Process exited with code ${result.exitCode}');
    }
  }

  @override
  Future<int> execute() async {
    final scope = (argResults?['scope'] as String).toLowerCase();
    widgetScope = WidgetScope.values.byName(scope);
    final widgetMeta = await getWidgetMeta(widgetName!);
    await downloadFiles(widgetMeta);

    return ExitCode.success.code;
  }

  @override
  FutureOr<bool> validate() {
    final args = argResults?.rest ?? [];
    if (args.isNotEmpty) {
      widgetName = args.first;
    }
    if (widgetName == null) {
      _logger.error('Widget name is required');
      return false;
    }
    return true;
  }
}

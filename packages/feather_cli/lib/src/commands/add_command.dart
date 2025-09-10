import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:feather_cli/src/registry/registry.dart';
import 'package:feather_cli/src/registry/widget_meta.dart';
import 'package:mason_logger/mason_logger.dart';

class AddCommand extends Command<int> {
  /// {@macro sample_command}
  AddCommand({required Logger logger}) : _logger = logger;

  @override
  String get description => 'A sample sub command that just prints one joke';

  @override
  String get name => 'add';

  final Logger _logger;

  /// Reads the registry.json file and returns it as a Map

  @override
  Future<int> run() async {
    // Get the parameter passed to the add command (first positional argument)
    final args = argResults?.rest ?? [];
    String? widgetName;
    if (args.isNotEmpty) {
      widgetName = args.first;
    }

    final widgetMeta = getWidgetMeta(widgetName!);

    if (widgetMeta == null) {
      _logger.err('Widget $widgetName not found in registry');
      return ExitCode.software.code;
    }
    //installDependency(widgetMeta);
    await downloadFiles(widgetMeta);

    //_logger.info(widgetMeta.toString());
    return ExitCode.success.code;
  }

  getRegistry(String widgetName) {
    return registry[widgetName];
  }

  WidgetMeta? getWidgetMeta(String widgetName) {
    return getRegistry(widgetName) as WidgetMeta?;
  }

  installDependency(WidgetMeta widgetMeta) {
    _runProcessAndLog("dart", ["pub", "add", ...widgetMeta.dependencies]);
  }

  Future<void> downloadFiles(WidgetMeta widgetMeta) async {
    await Future.wait(
      widgetMeta.files.map(
        (e) => downloadFileToTarget(e.absolutePath(), e.target),
      ),
    );
  }

  void _runProcessAndLog(String executable, List<String> arguments) {
    final result = Process.runSync(executable, arguments);
    if (result.stdout != null && result.stdout.toString().isNotEmpty) {
      _logger.info(result.stdout.toString());
    }
    if (result.stderr != null && result.stderr.toString().isNotEmpty) {
      _logger.err(result.stderr.toString());
    }
    if (result.exitCode != 0) {
      _logger.err('Process exited with code ${result.exitCode}');
    }
  }

  Future<void> downloadFileToTarget(String url, String target) async {
    print(url);
    try {
      final uri = Uri.parse(url);
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(uri);
      final response = await request.close();
      print(response.statusCode);
      if (response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        final file = File(target);
        await file.create(recursive: true);
        await file.writeAsBytes(bytes);
      } else {
        throw Exception(
          'Failed to download file: $url (Status: ${response.statusCode})',
        );
      }
      httpClient.close();
    } catch (e) {
      print('Error downloading $url to $target: $e');
      rethrow;
    }
  }

  /// Helper to read all bytes from a HttpClientResponse
  Future<List<int>> consolidateHttpClientResponseBytes(
    HttpClientResponse response,
  ) {
    final completer = Completer<List<int>>();
    final contents = <int>[];
    response.listen(
      (data) => contents.addAll(data),
      onDone: () => completer.complete(contents),
      onError: completer.completeError,
      cancelOnError: true,
    );
    return completer.future;
  }
}

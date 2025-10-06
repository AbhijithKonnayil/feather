import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:feather_core/feather_core.dart';
import 'package:mason_logger/mason_logger.dart';

abstract class FCommand extends Command<int> {
  FCommand();
  final Logger logger = FLogger();

  /// Override this for validation logic before executing
  FutureOr<bool> validate();

  /// Override this for actual command logic
  FutureOr<int> execute();

  @override
  Future<int> run() async {
    try {
      final isValid = await validate();
      if (isValid) {
        return await execute();
      }
      throw FException('Validation Error');
    } catch (e, stack) {
      logger
        ..err(e.toString())
        ..detail(stack.toString()); // only visible in verbose mode
      return ExitCode.software.code; // 70 = internal software error
    }
  }
}

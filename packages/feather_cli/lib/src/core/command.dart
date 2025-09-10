import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:feather_cli/src/core/exception.dart';
import 'package:feather_cli/src/core/logger.dart';
import 'package:mason_logger/mason_logger.dart';

abstract class FCommand extends Command<int> {
  final Logger logger = FLogger();
  FCommand();

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
      throw FException("Unexpected Error");
    } catch (e, stack) {
      logger.err(e.toString());
      logger.detail(stack.toString()); // only visible in verbose mode
      return ExitCode.software.code; // 70 = internal software error
    }
  }
}

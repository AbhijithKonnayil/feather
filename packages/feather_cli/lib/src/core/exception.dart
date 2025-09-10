import 'package:mason_logger/mason_logger.dart';

/// Base class for all Feather CLI errors
class FException implements Exception {
  final String message;
  final int exitCode;

  FException(
    this.message, {
    this.exitCode = 70,
  }); // default = software error

  @override
  String toString() => 'Error: $message';
}

class InvalidDirectoryException extends FException {
  InvalidDirectoryException(String message)
    : super(message, exitCode: ExitCode.usage.code);
}

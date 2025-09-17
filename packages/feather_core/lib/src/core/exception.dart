import 'package:mason_logger/mason_logger.dart';

/// Base class for all Feather CLI errors
class FException implements Exception {
  FException(
    this.message, {
    this.exitCode = 70,
  });
  final String message;
  final int exitCode; // default = software error

  @override
  String toString() => 'Error: $message';
}

class InvalidDirectoryException extends FException {
  InvalidDirectoryException(super.message)
    : super(exitCode: ExitCode.usage.code);
}

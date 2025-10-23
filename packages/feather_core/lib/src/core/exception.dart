import 'enums/exit_code.dart';

/// Base class for all Feather CLI errors
class FException implements Exception {
  FException(this.message, {this.exitCode = ExitCode.software});
  final String message;
  final ExitCode exitCode; // default = software error

  @override
  String toString() => 'Error: $message';
}

class InvalidDirectoryException extends FException {
  InvalidDirectoryException(super.message) : super(exitCode: ExitCode.usage);
}

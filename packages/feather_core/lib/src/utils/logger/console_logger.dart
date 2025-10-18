import 'package:feather_core/feather_core.dart';
import 'package:mason_logger/mason_logger.dart';

class FConsoleLogger extends Logger implements FLogger {
  static final FConsoleLogger _instance = FConsoleLogger._internal();
  factory FConsoleLogger() => _instance;
  FConsoleLogger._internal();

  @override
  void debug(String message) {}

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    err(message);
  }
}

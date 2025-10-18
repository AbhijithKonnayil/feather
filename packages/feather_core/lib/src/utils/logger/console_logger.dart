import 'package:feather_core/feather_core.dart';

export 'package:mason_logger/mason_logger.dart' hide ExitCode;

class FConsoleLogger implements FLogger {
  static final FConsoleLogger _instance = FConsoleLogger._internal();
  factory FConsoleLogger() => _instance;
  FConsoleLogger._internal();
  final Logger _logger = Logger();

  void setLogLevel(Level level) {
    _logger.level = level;
  }

  @override
  void debug(String message) {
    _logger.detail(message);
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.err(message);
  }

  @override
  void info(String message) {
    _logger.info(message);
  }

  @override
  void success(String message) {
    _logger.success(message);
  }

  @override
  void warn(String message) {
    _logger.warn(message);
  }

  Progress progress(String s) {
    return _logger.progress(s);
  }

  String prompt(String s) {
    return _logger.prompt(s);
  }
}

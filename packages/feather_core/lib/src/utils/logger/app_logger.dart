import 'package:logger/logger.dart';

import './logger.dart';

class FAppLogger implements FLogger {
  static final FAppLogger _instance = FAppLogger._internal();
  factory FAppLogger() => _instance;
  FAppLogger._internal();
  final Logger _logger = Logger();
  @override
  void debug(String message) {
    _logger.d(message);
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  @override
  void info(String message) {
    _logger.i(message);
  }

  @override
  void success(String message) {
    _logger.i(message);
  }

  @override
  void warn(String message) {
    _logger.w(message);
  }
}

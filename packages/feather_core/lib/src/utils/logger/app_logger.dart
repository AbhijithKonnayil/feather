import 'package:logger/logger.dart';

import './logger.dart';

class FAppLogger extends Logger implements FLogger {
  static final FAppLogger _instance = FAppLogger._internal();
  factory FAppLogger() => _instance;
  FAppLogger._internal();

  @override
  void debug(String message) {
    d(message);
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    f(message, error: error, stackTrace: stackTrace);
  }

  @override
  void info(String message) {
    i(message);
  }

  @override
  void success(String message) {
    i(message);
  }

  @override
  void warn(String message) {
    w(message);
  }
}

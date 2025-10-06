import 'package:mason_logger/mason_logger.dart';

class FLogger extends Logger {
  factory FLogger() {
    return _instance;
  }
  FLogger._internal();

  static final FLogger _instance = FLogger._internal();
}

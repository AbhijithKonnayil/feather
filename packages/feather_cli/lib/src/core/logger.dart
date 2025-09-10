import 'package:mason_logger/mason_logger.dart';

class FLogger extends Logger {
  FLogger._internal();

  static final FLogger _instance = FLogger._internal();

  final Logger logger = Logger();

  factory FLogger() {
    return _instance;
  }
}

abstract class FLogger {
  void info(String message);
  void warn(String message);
  void error(String message, [Object? error, StackTrace? stackTrace]);
  void success(String message);
  void debug(String message);
}

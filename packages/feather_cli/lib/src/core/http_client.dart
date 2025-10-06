import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// remove example part files
///
/// part 'text_field_01.example.dart';
/// part "text_field_01.example.dart";

final _partExampleRegex = RegExp(
  r'''^part\s+["\'][\w_]+\.example\.dart["\'];$''',
  multiLine: true,
);

final _featherCoreImportRegex = RegExp(
  r'''^\s*import\s+["\']package:feather_core\/feather_core\.dart["\'];\s*$''',
  multiLine: true,
);
final annotationRegex = RegExp(
  r'@(Component|Page)Meta\s*\([\s\S]*?\)\s*',
  multiLine: true,
);

class FHttpClient {
  // Private constructor
  FHttpClient._internal() {
    _httpClient = HttpClient();
    _httpClient.connectionTimeout = const Duration(seconds: 30);
  }

  // Singleton instance
  static final FHttpClient _instance = FHttpClient._internal();

  // Factory constructor to return the same instance
  factory FHttpClient() => _instance;

  late final HttpClient _httpClient;

  /// Fetch data from a URL and return decoded JSON (or plain text if not JSON)
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final request = await _httpClient.getUrl(uri);

    headers?.forEach((key, value) {
      request.headers.add(key, value);
    });

    final response = await request.close();

    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();

      try {
        return jsonDecode(responseBody);
      } catch (_) {
        return responseBody;
      }
    } else {
      throw HttpException(
        'GET $url failed (Status: ${response.statusCode})',
        uri: uri,
      );
    }
  }

  /// Download file from URL to target path
  Future<void> downloadFile(String url, String targetPath) async {
    final uri = Uri.parse(url);
    final request = await _httpClient.getUrl(uri);
    final response = await request.close();

    if (response.statusCode == 200) {
      final bytes = await consolidateHttpClientResponseBytes(response);
      final file = File(targetPath);
      await file.create(recursive: true);

      // Decide how to persist based on target extension and response content type
      final contentType = response.headers.contentType?.mimeType;
      final isDartTarget = targetPath.toLowerCase().endsWith('.dart');
      final looksText =
          contentType != null &&
          (contentType.startsWith('text/') ||
              contentType == 'application/dart');

      if (isDartTarget || looksText) {
        // Decode as UTF-8 text and clean Dart-specific directives
        var content = utf8.decode(bytes);

        /// remove part example
        content = content.replaceAll(
          _partExampleRegex,
          '',
        );

        /// remove feather core import
        content = content.replaceAll(
          _featherCoreImportRegex,
          '',
        );

        /// Remove `@ComponentMeta(...)` annotation block
        content = content.replaceAll(
          annotationRegex,
          '',
        );
        await file.writeAsString(content);
      } else {
        // Binary or non-text content: write raw bytes
        await file.writeAsBytes(bytes);
      }
    } else {
      throw HttpException(
        'File download failed: $url (Status: ${response.statusCode})',
        uri: uri,
      );
    }
  }

  /// Helper to read all bytes from a HttpClientResponse
  Future<List<int>> consolidateHttpClientResponseBytes(
    HttpClientResponse response,
  ) {
    final completer = Completer<List<int>>();
    final contents = <int>[];
    response.listen(
      contents.addAll,
      onDone: () => completer.complete(contents),
      onError: completer.completeError,
      cancelOnError: true,
    );
    return completer.future;
  }

  /// Close the HTTP client (optional, usually keep alive for app lifetime)
  void close() {
    _httpClient.close(force: true);
  }
}

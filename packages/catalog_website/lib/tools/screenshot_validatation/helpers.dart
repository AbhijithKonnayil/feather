part of 'validate.dart';

// Resolve a filesystem path relative to catalog_website/lib/_generated
String _relFromGenerated(String relative) {
  final scriptDir = File(
    Platform.script.toFilePath(),
  ).parent; // .../lib/tools/screenshot_validatation
  final generatedDir = Directory.fromUri(
    scriptDir.uri.resolve('../../_generated/'),
  );
  return File.fromUri(generatedDir.uri.resolve(relative)).path;
}

String _relPathFromScope(WidgetScope scope) {
  final relPath =
      '../../../feather_registry/lib/widget_meta/${scope.name}.g.json';
  return _relFromGenerated(relPath);
}

String _getScreenshotPath(WidgetScope scope, String widgetId, Screens screen) {
  final basePath = _relFromGenerated('../../assets/screenshots');
  final scopePath = scope.name; // 'page', 'component', 'block'
  final fileName = '${widgetId}_${screen.name}.jpeg';

  return '$basePath/$scopePath/$fileName';
}

Future<List<double>?> getImageSize(String filePath) async {
  try {
    final file = File(filePath);

    if (!await file.exists()) {
      throw Exception('File not found: $filePath');
    }

    final bytes = await file.readAsBytes();
    final fileSize = await file.length();
    final kb = fileSize / 1024;

    final image = img.decodeImage(bytes);
    if (kb > 100) {
      throw FileSizeExceedException(message: 'Image size exceeds 200 KB');
    }
    if (image == null) {
      throw Exception('Failed to decode image: $filePath');
    }

    return [image.width.toDouble(), image.height.toDouble(), kb];
  } catch (e) {
    //throw Exception('Error reading image $filePath: $e');
    rethrow;
  }
}

bool _validateImageDimensions(List<double> dimensions, Screens screen) {
  final requiredSize = previewSizes[screen];
  if (dimensions[0] == requiredSize![0] && dimensions[1] == requiredSize[1]) {
    return true;
  }
  /// if image is larger than required size
  /// and aspect ratio is same
  else if (dimensions[0] / dimensions[1] == requiredSize[0] / requiredSize[1] &&
      dimensions[0] > requiredSize[0] &&
      dimensions[1] > requiredSize[1]) {
    return true;
  }
  return false;
}

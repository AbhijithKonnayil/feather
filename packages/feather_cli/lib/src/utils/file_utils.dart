import 'dart:io';

import 'package:feather_cli/src/core/exception.dart';
import 'package:feather_cli/src/core/logger.dart';
import 'package:yaml/yaml.dart';

class FileUtils {
  static final FLogger _logger = FLogger();

  static bool isFlutterDirectory(String path) {
    final pubspecFile = File('$path/pubspec.yaml');
    if (!pubspecFile.existsSync()) return false;
    final content = pubspecFile.readAsStringSync();
    return RegExp(r'^\s*flutter\s*:', multiLine: true).hasMatch(content);
  }

  static Directory? findProjectRoot(Directory startDir) {
    var dir = startDir;
    while (true) {
      final pubspec = File('${dir.path}/pubspec.yaml');
      if (pubspec.existsSync()) return dir;
      final parent = dir.parent;
      if (parent.path == dir.path) return null;
      dir = parent;
    }
  }

  static bool isInsidePackage(
    String packageName,
  ) {
    final root = findProjectRoot(Directory.current);
    if (root == null) {
      throw InvalidDirectoryException('Not inside a Dart/Flutter project.');
    }
    final yaml = loadYaml(File('${root.path}/pubspec.yaml').readAsStringSync());
    if (yaml['name'] != packageName) {
      throw InvalidDirectoryException(
        'This command must be run inside the $packageName package.',
      );
    }
    return true;
  }

  static Future<void> createFile(String path, String content) async {
    try {
      final file = File(path);
      await file.create(recursive: true); // create dirs if not exist
      await file.writeAsString(content);

      _logger.success('✅ File created: $path');
    } on FileSystemException catch (e) {
      _logger
        ..err('❌ Failed to create file: $path')
        ..detail(e.toString());
      rethrow; // let caller handle if needed
    } catch (e) {
      _logger.err('❌ Unexpected error while creating file: $e');
      rethrow;
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:catalog_website/core/preview_sizes.dart';
import 'package:feather_core/feather_core.dart';
import 'package:image/image.dart' as img;

import 'models.dart';

part 'helpers.dart';

void main(List<String> arguments) async {
  final isVerbose = arguments.contains('--verbose');
  print("$arguments $isVerbose");
  final parser = ArgParser()
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Show detailed validation output',
      negatable: false,
    );

  final argResults = parser.parse(arguments);
  final verbose = argResults['verbose'] as bool;

  if (verbose) {
    print('🔍 Starting widget screenshot validation in verbose mode...\n');
  } else {
    print('🔍 Starting widget screenshot validation...\n');
  }
  print('🔍 Starting widget screenshot validation...\n');

  final validationResults = await validateAllWidgetScreenshotsFromJson(
    verbose: verbose,
  );

  if (validationResults.issues.isNotEmpty) {
    print('\n🚨 ISSUES FOUND:');
    print('=' * 50);
    int index = 0;
    for (final issue in validationResults.issues) {
      print('${++index}. ${issue.type}: ${issue.message}');
      if (issue.details != null) {
        print('${issue.details}\n');
      }
    }
  }

  if (validationResults.validCount == validationResults.totalScreenshots &&
      validationResults.missingCount == 0 &&
      validationResults.invalidDimensionsCount == 0) {
    print('\n🎉 All screenshots are valid!');
  }
  printSummary(validationResults);
}

void printSummary(ValidationResult validationResults) {
  print('\n📊 VALIDATION SUMMARY:');
  print('=' * 50);
  print('✅ Valid screenshots: ${validationResults.validCount}');
  print('❌ Missing screenshots: ${validationResults.missingCount}');
  print('⚠️  Invalid dimensions: ${validationResults.invalidDimensionsCount}');
  print('⚠️  Invalid size: ${validationResults.invalidSizeCount}');
  print('📁 Total widgets checked: ${validationResults.totalWidgets}');
  print(
    '🖼️  Total screenshots checked: ${validationResults.totalScreenshots}',
  );
}

Future<ValidationResult> validateAllWidgetScreenshotsFromJson({
  bool verbose = false,
}) async {
  final jsonFiles = <(String scope, String path)>[
    ('page', _relPathFromScope(WidgetScope.page)),
    ('block', _relPathFromScope(WidgetScope.block)),
    ('component', _relPathFromScope(WidgetScope.component)),
  ];

  if (verbose) {
    print('📂 JSON files to process:');
    for (final (scope, path) in jsonFiles) {
      print('  - $scope: $path');
    }
    print('');
  }

  final allEntries = <WidgetMeta>[];

  for (final (scope, path) in jsonFiles) {
    if (verbose) {
      print('🔍 Processing $scope widgets from $path');
    }
    final entries = await _readWidgetEntriesFromJson(path, scope);
    if (verbose) {
      print('   Found ${entries.length} widget entries');
    }
    allEntries.addAll(entries);
  }

  if (verbose) {
    print('\n🔍 Found ${allEntries.length} total widget entries');
  }

  int validCount = 0;
  int missingCount = 0;
  int invalidDimensionsCount = 0;
  int invalidSizeCount = 0;
  int totalScreenshots = 0;
  final issues = <ValidationIssue>[];

  print('📋 Found ${allEntries.length} widgets to validate\n');

  for (final entry in allEntries) {
    if (verbose) print('\n🔍 Validating ${entry.id} (${entry.scope})');

    for (final screen in Screens.values) {
      totalScreenshots++;
      final screenshotPath = _getScreenshotPath(entry.scope, entry.id, screen);

      if (verbose) {
        print('   Checking ${screen.name} screenshot at: $screenshotPath');
      }

      try {
        final dimensions = await getImageSize(screenshotPath);
        if (dimensions == null) {
          throw Exception('Failed to read image dimensions');
        }

        _validateImageDimensions(dimensions, screen);
        validCount++;

        if (verbose) {
          print(
            '   ✅ Valid ${screen.name} screenshot: ${dimensions[0]}x${dimensions[1]} (${dimensions[2].toStringAsFixed(2)} KB)',
          );
        }
      } on FileSizeExceedException catch (e) {
        issues.add(
          ValidationIssue(
            type: 'FILE_SIZE_EXCEEDED',
            message: 'Screenshot Size too large: $screenshotPath',
            details: e.message,
          ),
        );
        invalidSizeCount++;

        if (verbose) {
          print('   ❌ ${e.message}');
        }
      } on InvalidDimensionException catch (e) {
        issues.add(
          ValidationIssue(
            type: 'INVALID_DIMENSIONS',
            message: 'Invalid dimensions for $screenshotPath',
            details: e.message,
          ),
        );
        invalidDimensionsCount++;

        if (verbose) {
          print('   ❌ ${e.message}');
        }
      } catch (e) {
        issues.add(
          ValidationIssue(
            type: 'MISSING_OR_INVALID',
            message: 'Missing or invalid screenshot: $screenshotPath',
            details: e.toString(),
          ),
        );
        missingCount++;

        if (verbose) {
          print('   ❌ Missing ${e.toString()}');
        }
      }
    }
    if (verbose) {
      print('');
    }
  }

  return ValidationResult(
    validCount: validCount,
    missingCount: missingCount,
    invalidDimensionsCount: invalidDimensionsCount,
    totalWidgets: allEntries.length,
    totalScreenshots: totalScreenshots,
    issues: issues,
    invalidSizeCount: invalidSizeCount,
  );
}

Future<List<WidgetMeta>> _readWidgetEntriesFromJson(
  String absolutePath,
  String scopeStr,
) async {
  final file = File(absolutePath);
  if (!await file.exists()) {
    return [];
  }

  final content = await file.readAsString();
  if (content.trim().isEmpty) {
    return [];
  }

  final Map<String, dynamic> data =
      json.decode(content) as Map<String, dynamic>;
  final entries = <WidgetMeta>[];

  for (final entry in data.entries) {
    entries.add(WidgetMeta.fromJson(entry.value));
  }
  return entries;
}

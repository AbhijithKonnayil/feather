class ValidationResult {
  final int validCount;
  final int missingCount;
  final int invalidDimensionsCount;
  final int totalWidgets;
  final int invalidSizeCount;
  final int totalScreenshots;
  final List<ValidationIssue> issues;

  ValidationResult({
    required this.validCount,
    required this.missingCount,
    required this.invalidDimensionsCount,
    required this.invalidSizeCount,
    required this.totalWidgets,
    required this.totalScreenshots,
    required this.issues,
  });
}

class ValidationIssue {
  final String type;
  final String message;
  final String? details;

  ValidationIssue({required this.type, required this.message, this.details});
}

class InvalidDimensionException implements Exception {
  final String message;

  InvalidDimensionException({required this.message});
}

class FileSizeExceedException implements Exception {
  final String message;

  FileSizeExceedException({required this.message});
}

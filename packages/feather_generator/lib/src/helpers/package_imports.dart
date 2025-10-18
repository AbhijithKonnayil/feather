import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:feather_core/feather_core.dart';

class PackageImportsHelper {
  static late final FAppLogger logger;

  PackageImportsHelper([FAppLogger? logger]) {
    logger = logger ?? FAppLogger();
  }

  /// Extracts the raw URI strings (best-effort) imported by the entire library
  /// that contains [element]. Uses canonical URIs of imported libraries.
  static Set<String> getLibraryImportUris(Element element) {
    final library = element.library;
    if (library == null) return <String>{};

    final uris = <String>{};
    for (final fragment in library.fragments) {
      for (final libImport in fragment.libraryImports) {
        final importedLib = libImport.importedLibrary;
        final uri = importedLib?.uri;
        if (uri != null) {
          uris.add(uri.toString());
        }
      }
    }
    return uris;
  }

  /// Validates that all imported packages are allowed.
  static bool validatePackages({
    required List<String> importedPackages,
    required List<String> allowedPackages,
  }) {
    for (final import in importedPackages) {
      bool isAllowed = allowedPackages.any(
        import.startsWith,
      );
      if (!isAllowed) {
        logger
          ..error('Package not allowed: $import')
          ..error(
            'only import from these packages are allowed: $allowedPackages',
          );
        return false;
      }
    }
    return true;
  }
}

/// Utilities to inspect imports of the library or the exact unit (file)
/// that contains a given [Element] (e.g., where an annotation is used).
///
/// Typical usage from a `GeneratorForAnnotation`:
///
/// ```dart
/// final libPkgs = getLibraryPackageImports(element).toList()..sort();
/// final unitPkgs = getUnitPackageImports(element).toList()..sort();
/// ```

/// Extracts package names (e.g. `my_pkg`) imported by the entire library
/// that contains [element]. This includes imports brought in by the main
/// library file and visible to all parts.
Set<String> getLibraryPackageImports(Element element) {
  final library = element.library;
  if (library == null) return <String>{};

  final packages = <String>{};

  // Iterate all fragments (defining unit + parts) and collect their import directives.
  for (final fragment in library.fragments) {
    for (final libImport in fragment.libraryImports) {
      print("lib > $libImport");
      final importedLib = libImport.importedLibrary;
      final uri = importedLib?.uri; // canonical uri of imported library
      if (uri == null) continue;
      if (uri.scheme == 'package') {
        final segments = uri.pathSegments;
        if (segments.isNotEmpty) packages.add(segments.first);
      }
    }
  }

  return packages;
}

/// Extracts package names (e.g. `my_pkg`) imported by the specific compilation
/// unit (file) that contains [element]. This is more precise than
/// [getLibraryPackageImports] for cases where the library has many parts and you
/// only care about the file where the annotation appears.
Set<String> getUnitPackageImports(Element element) {
  final unit = _getParsedUnitForElement(element);
  if (unit == null) return <String>{};

  final packages = <String>{};
  for (final directive in unit.directives.whereType<ImportDirective>()) {
    final uriStr = directive.uri.stringValue; // e.g. package:foo/bar.dart
    if (uriStr == null) continue;
    if (uriStr.startsWith('package:')) {
      final rest = uriStr.substring('package:'.length);
      final slash = rest.indexOf('/');
      if (slash > 0) {
        packages.add(rest.substring(0, slash));
      }
    }
  }
  return packages;
}

/// Extracts the raw URI strings imported by the specific compilation unit
/// (file) that contains [element], using the AST of that unit.
Set<String> getUnitImportUris(Element element) {
  final unit = _getParsedUnitForElement(element);
  if (unit == null) return <String>{};

  final uris = <String>{};
  for (final directive in unit.directives.whereType<ImportDirective>()) {
    final uriStr = directive.uri.stringValue;
    if (uriStr != null && uriStr.isNotEmpty) {
      uris.add(uriStr);
    }
  }
  return uris;
}

// --- Internals ---

/// Returns the [CompilationUnit] for the same source file that declares
/// [element], using ParsedLibraryResult.
CompilationUnit? _getParsedUnitForElement(Element element) {
  final library = element.library;
  final session = library?.session;
  if (library == null || session == null) return null;

  final parsed = session.getParsedLibraryByElement(library);
  if (parsed is! ParsedLibraryResult) return null;

  // Use fragment declaration API to find the unit that contains the element's fragment.
  final decl = parsed.getFragmentDeclaration(element.firstFragment);
  return decl?.parsedUnit?.unit;
}

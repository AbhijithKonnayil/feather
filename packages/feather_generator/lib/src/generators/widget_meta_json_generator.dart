import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:feather_core/feather_core.dart';
import 'package:source_gen/source_gen.dart';

class WidgetMetaJsonGenerator extends GeneratorForAnnotation<WidgetMeta> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final id = annotation.read('id').stringValue;
    final name = annotation.read('name').stringValue;
    final scope = annotation
        .read('scope')
        .objectValue
        .getField('_name')
        ?.toStringValue();
    final description = annotation.read('description').stringValue;
    final dependencies = annotation
        .read('dependencies')
        .listValue
        .map((v) => v.toStringValue() ?? '')
        .toList();

    final categories = extractEnumValues(annotation, 'categories');
    final types = extractEnumValues(annotation, 'types');
    final screens = extractEnumValues(annotation, 'screens');

    final uri = element.library?.uri; // safer than .uri
    final decoded = uri != null ? Uri.decodeComponent(uri.toString()) : null;
    //TODO
    final files = [];

    // Example: return as a JSON string
    return '''
{
  "id":"$id",
  "name": "$name",
  "description": "$description",
  "import":"$decoded",
  "example":"buildExampleWidgetFor_$id()",
  "screens":${screens.toJsonListString()},
  "types": ${types.toJsonListString()},
  "categories": ${categories.toJsonListString()},
  "scope":"$scope"
}
''';
  }

  List<String> extractEnumValues(ConstantReader annotation, String fieldName) {
    return annotation
        .read(fieldName)
        .listValue
        .map((v) {
          return v.getField('_name')?.toStringValue() ?? '';
        })
        .where((v) => v.isNotEmpty)
        .toList();
  }
}

extension QuotedList on List<String> {
  /// Maps list of strings into `"a", "b", "c"` format
  List<String> toJsonListString() => map((d) => '"$d"').toList();
}

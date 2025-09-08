import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:feather_core/feather_core.dart';
import 'package:source_gen/source_gen.dart';

class WidgetMetaJsonGenerator extends GeneratorForAnnotation<WidgetMeta> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final id = annotation.read('id').stringValue;
    final name = annotation.read('name').stringValue;
    final description = annotation.read('description').stringValue;
    final dependencies = annotation
        .read('dependencies')
        .listValue
        .map((v) => v.toStringValue() ?? '')
        .toList();
    final uri = element.library?.uri; // safer than .uri
    final decoded = uri != null ? Uri.decodeComponent(uri.toString()) : null;

    // Example: return as a JSON string
    return '''
{
  "id":"$id",
  "name": "$name",
  "description": "$description",
  "import":"$decoded",
  "example":"exampleWidgetBuilder()",
  "dependencies": ${dependencies.map((d) => '"$d"').toList()}
}
''';
  }
}

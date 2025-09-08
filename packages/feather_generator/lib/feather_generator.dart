import 'package:build/build.dart' show Builder, BuilderOptions;
import 'package:feather_generator/src/builders/json_builder.dart'
    show JsonBuilder;
import 'package:feather_generator/src/generators/widget_meta_json_generator.dart'
    show WidgetMetaJsonGenerator;

Builder widgetMetaJsonBuilder(BuilderOptions options) => JsonBuilder(
  WidgetMetaJsonGenerator(),
  formatOutput: (input) {
    final joined = input.replaceAll('\n\n', ',\n');
    return '[$joined]';
  },
  generatedExtension: '.feather_widget_meta.json',
);

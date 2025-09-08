import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:glob/glob.dart';

class JsonCombinationBuilder extends Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    try {
      final glob = Glob('**.feather_widget_meta.json');

      // Collect and flatten into a single list
      final allMaps = <String, dynamic>{};
      final importBuffer = StringBuffer(
        "import 'package:feather_core/feather_core.dart';",
      )..writeln();
      final listString = StringBuffer()
        ..writeln()
        ..writeln('final widgetList = [');
      await for (final asset in buildStep.findAssets(glob)) {
        final content = await buildStep.readAsString(asset);
        final parsed = (jsonDecode(content) as List)
            .cast<Map<String, dynamic>>();
        //allMaps.addAll(parsed);
        for (final widgetMeta in parsed) {
          final id = widgetMeta['id'] as String;
          final name = widgetMeta['name'] as String;
          final description = widgetMeta['description'] as String;
          final import = widgetMeta['import'] as String;
          const type = 'ui';
          if (allMaps.containsKey(id)) {
            throw StateError(
              'Duplicate widget ID "$id" found in asset: ${asset.path}',
            );
          }
          importBuffer.writeln("import '$import' as $id;");
          listString
            ..writeln('WidgetDetails(')
            ..writeln("id:'$id',")
            ..writeln("name:'$name',")
            ..writeln("description:'$description',")
            ..writeln('example:$id.buildExampleWidget,')
            ..writeln('type:WidgetType.$type,')
            ..writeln('files:[],')
            ..writeln('),');
          allMaps[id] = widgetMeta;
        }
      }
      listString.writeln('];');
      await Future.wait([
        writeDartList(
          importBuffer.toString() + listString.toString(),
          buildStep,
        ),
        writeJsonList(allMaps, buildStep),
      ]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> writeDartList(
    String content,
    BuildStep buildStep,
  ) async {
    final assetId = AssetId('feather_ui', 'lib/.generated/list.g.dart');
    await buildStep.writeAsString(assetId, content);
  }

  Future<void> writeJsonList(
    Map<String, dynamic> allMaps,
    BuildStep buildStep,
  ) async {
    // Encode once, at the end
    const encoder = JsonEncoder.withIndent('  '); // 2 spaces

    final jsonString = encoder.convert(allMaps);

    final assetId = AssetId('feather_ui', 'lib/.generated/list.g.json');
    await buildStep.writeAsString(assetId, jsonString);
  }

  @override
  final buildExtensions = const {
    r'$lib$': [
      '.generated/list.g.json',
      '.generated/list.g.dart',
    ], // one output per package
  };
}

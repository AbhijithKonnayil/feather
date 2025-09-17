import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:change_case/change_case.dart';
import 'package:feather_core/feather_core.dart';
import 'package:glob/glob.dart';

class JsonCombinationBuilder extends Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    try {
      final glob = Glob('**.feather_widget_meta.json');
      final Map<WidgetScope, _BufferAdapter> scopeMap = {
        WidgetScope.component: _BufferAdapter(
          contentBuffer: StringBuffer(),
          importBuffer: StringBuffer(),
          map: {},
        ),
        WidgetScope.block: _BufferAdapter(
          contentBuffer: StringBuffer(),
          importBuffer: StringBuffer(),
          map: {},
        ),
        WidgetScope.page: _BufferAdapter(
          contentBuffer: StringBuffer(),
          importBuffer: StringBuffer(),
          map: {},
        ),
      };

      scopeMap.values.forEach((buffer) {
        buffer.importBuffer
          ..writeln("import 'package:feather_core/feather_core.dart';")
          ..writeln();
      });

      scopeMap.entries.forEach((entry) {
        entry.value.contentBuffer
          ..writeln()
          ..writeln('final ${entry.key.name}List = [');
      });

      late WidgetScope widgetScope;
      await for (final asset in buildStep.findAssets(glob)) {
        final content = await buildStep.readAsString(asset);
        final parsed = (jsonDecode(content) as List)
            .cast<Map<String, dynamic>>();
        for (final widgetMeta in parsed) {
          final id = widgetMeta['id'] as String;
          final name = widgetMeta['name'] as String;
          final description = widgetMeta['description'] as String;
          final import = widgetMeta['import'] as String;
          final categories = widgetMeta['categories'] as List;
          final types = widgetMeta['types'] as List;
          final screens = widgetMeta['screens'] as List;
          final scope = widgetMeta['scope'] as String;
          widgetScope = WidgetScope.values.byName(scope);

          final categoryEnumPrefix = '${scope}Category'.toPascalCase();
          final typeEnumPrefix = '${scope}Type'.toPascalCase();
          if (scopeMap[widgetScope]!.map.containsKey(id)) {
            throw StateError(
              'Duplicate widget ID "$id" found in asset: ${asset.path}',
            );
          }
          //
          scopeMap[widgetScope]!.importBuffer.writeln("import '$import';");

          scopeMap[widgetScope]!.contentBuffer
            ..writeln('WidgetDetails(')
            ..writeln("id:'$id',")
            ..writeln("name:'$name',")
            ..writeln('scope:$widgetScope,')
            ..writeln("description:'$description',")
            ..writeln('example:buildExampleWidgetFor_$id,')
            ..writeln(
              'screens:${screens.map((e) => "Screens.$e").toList()},',
            )
            ..writeln(
              'categories:${categories.map((e) => "$categoryEnumPrefix.$e").toList()},',
            )
            ..writeln(
              'types:${types.map((e) => "$typeEnumPrefix.$e").toList()},',
            )
            ..writeln('files:[],')
            ..writeln('),');
          scopeMap[widgetScope]!.map[id] = widgetMeta;
        }

        ///end of json parsed loop
      } //end of glob file loop

      scopeMap.entries.forEach((entry) {
        entry.value.contentBuffer
          ..writeln()
          ..writeln('];');
      });
      final writeFn = scopeMap.entries.map((
        entries,
      ) {
        final importBuffer = entries.value.importBuffer.toString();
        final contentBuffer = entries.value.contentBuffer.toString();
        return writeDartList(
          content: importBuffer + contentBuffer,
          fileName: entries.key.name,
          buildStep: buildStep,
        );
      });

      final jsonWriteFn = scopeMap.entries.map((
        entries,
      ) {
        return writeJsonList(
          map: entries.value.map,
          fileName: entries.key.name,
          buildStep: buildStep,
        );
      });
      await Future.wait([
        ...writeFn,
        ...jsonWriteFn,
      ]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> writeDartList({
    required String content,
    required String fileName,
    required BuildStep buildStep,
  }) async {
    final assetId = AssetId(
      'feather_ui',
      '$_generateLocation/$fileName.g.dart',
    );
    await buildStep.writeAsString(assetId, content);
  }

  Future<void> writeJsonList({
    required Map<String, dynamic> map,
    required BuildStep buildStep,
    required String fileName,
  }) async {
    // Encode once, at the end
    const encoder = JsonEncoder.withIndent('  '); // 2 spaces

    final jsonString = encoder.convert(map);

    final assetId = AssetId(
      'feather_ui',
      '$_generateLocation/$fileName.g.json',
    );
    await buildStep.writeAsString(assetId, jsonString);
  }

  static const String _generateLocation = 'lib/_generated';
  @override
  final buildExtensions = {
    r'$lib$': [
      ...WidgetScope.values.map((e) => '_generated/${e.name}.g.dart'),
      ...WidgetScope.values.map((e) => '_generated/${e.name}.g.json'),
    ], // one output per package
  };
}

class _BufferAdapter {
  final StringBuffer contentBuffer;
  final StringBuffer importBuffer;
  final Map<String, dynamic> map;
  _BufferAdapter({
    required this.contentBuffer,
    required this.importBuffer,
    required this.map,
  });
}

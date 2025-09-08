import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:glob/glob.dart';

class JsonCombinationBuilder extends Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    final glob = Glob('**.feather_widget_meta.json');

    // Collect and flatten into a single list
    final allMaps = <Map<String, dynamic>>[];

    await for (final asset in buildStep.findAssets(glob)) {
      final content = await buildStep.readAsString(asset);
      final parsed = (jsonDecode(content) as List).cast<Map<String, dynamic>>();
      allMaps.addAll(parsed);
      print("allMaps $allMaps");
    }

    // Encode once, at the end
    const encoder = JsonEncoder.withIndent('  '); // 2 spaces

    final jsonString = encoder.convert(allMaps);

    final assetId = AssetId('feather_ui', 'lib/.generated/list.g.json');
    await buildStep.writeAsString(assetId, jsonString);
  }

  @override
  final buildExtensions = const {
    r'$lib$': ['.generated/list.g.json'], // one output per package
  };
}

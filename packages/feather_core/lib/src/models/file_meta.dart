import 'package:json_annotation/json_annotation.dart';

part 'file_meta.g.dart';

@JsonSerializable()
class FileMeta {
  FileMeta({
    required this.path,
    required this.type,
    required this.target,
    this.isExternal = false,
  });

  /// Path relative to `feather_ui/lib/widgets
  final String path;
  final String? type;
  final String? target;
  final bool isExternal;
  factory FileMeta.fromJson(Map<String, dynamic> json) =>
      _$FileMetaFromJson(json);
  Map<String, dynamic> toJson() => _$FileMetaToJson(this);
  dynamic toJson_() {
    return {'path': path, 'type': type, 'target': target};
  }

  String absolutePath() {
    if (isExternal) return path;
    const baseRepo =
        'https://raw.githubusercontent.com/AbhijithKonnayil/feather/refs/heads/main/packages/';

    const uiRepo = "feather_ui/";
    const widgetFolder = "lib/";
    return '$baseRepo$uiRepo$widgetFolder$path';
  }
}

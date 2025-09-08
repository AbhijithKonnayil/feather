class FileMeta {
  FileMeta({
    required this.path,
    required this.type,
    required this.target,
    this.isExternal = false,
  });

  /// Path relative to `feather_ui/lib/widgets
  final String path;
  final String type;
  final String target;
  final bool isExternal;
  dynamic toJson() {
    return {'path': path, 'type': type, 'target': target};
  }

  String absolutePath() {
    if (isExternal) return path;
    const baseRepo =
        'https://raw.githubusercontent.com/AbhijithKonnayil/feather/5-Feature-implement-%60feather_cli%60/packages/';

    const uiRepo = "feather_ui/";
    const widgetFolder = "lib/widgets/";
    return '$baseRepo$uiRepo$widgetFolder$path';
  }
}

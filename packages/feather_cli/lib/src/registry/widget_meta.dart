enum WidgetType { block, ui }

class WidgetMeta {
  WidgetMeta({
    required this.name,
    required this.description,
    required this.type,
    required this.files,
    this.dependencies = const [],
    this.registryDependencies = const [],
  });
  final String name;
  final String description;
  final WidgetType type;
  final List<String> dependencies;
  final List<String> registryDependencies;
  final List<FileMeta> files;

  dynamic toJson() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'dependencies': dependencies,
      'registryDependencies': registryDependencies,
      'files': files.map((file) => file.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

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
    return {
      'path': path,
      'type': type,
      'target': target,
    };
  }

  String absolutePath() {
    if (isExternal) return path;
    const baseRepo =
        'https://raw.githubusercontent.com/AbhijithKonnayil/feather/5-Feature-implement-%60feather_cli%60/packages/';

    const uiRepo = 'feather_ui/';
    const widgetFolder = 'lib/widgets/';
    return '$baseRepo$uiRepo$widgetFolder$path';
  }
}

import 'package:feather_cli/src/registry/widget_meta.dart';

final Map<String, WidgetMeta> registry = {
  'button': WidgetMeta(
    name: 'button',
    description: 'A button widget',
    type: WidgetType.ui,
    dependencies: [],
    files: [
      FileMeta(
        path: 'button.dart',
        type: 'dart',
        target: 'lib/widgets/button.dart',
      ),
    ],
  ),
  'fluentButton': WidgetMeta(
    name: "Fluent Button",
    description: "",
    type: WidgetType.ui,
    files: [
      FileMeta(
        path:
            "https://raw.githubusercontent.com/bdlukaa/fluent_ui/refs/heads/master/lib/src/controls/buttons/base.dart",
        type: "type",
        target: "lib/widgets/fluentButton/base.dart",
        isExternal: true,
      ),
      FileMeta(
        path:
            "https://raw.githubusercontent.com/bdlukaa/fluent_ui/refs/heads/master/lib/src/controls/buttons/button.dart",
        type: "dart",
        target: "lib/widgets/fluentButton/button.dart",
        isExternal: true,
      ),
    ],
  ),
};

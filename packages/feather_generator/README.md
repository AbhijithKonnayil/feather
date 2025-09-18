# feather_generator

Source-gen builders for the Feather ecosystem. Scans your code for `feather_core` annotations (e.g., `ComponentMeta`, `BlockMeta`, `PageMeta`) and generates JSON metadata used by docs/catalog tooling.

- Tech: Dart build system (build, source_gen, analyzer)
- Consumes: `feather_core` annotations
- Produces: `*.feather_widget_meta.json` files and a combined manifest

## Install

Add as a dev dependency in your app or package:

```yaml
dev_dependencies:
  build_runner: ^2.8.0
  feather_generator: any
```

## Usage

1. Annotate your widgets using `feather_core` annotations, for example:

```dart
import 'package:feather_core/feather_core.dart';

@ComponentMeta(
  id: 'feather_btn_01',
  name: 'Feather Button',
  description: 'A Feather demo button.',
  files: [],
  types: [ComponentType.interactive],
  categories: [ComponentCategory.button],
  screens: [Screens.mobile, Screens.desktop],
)
class FeatherButton {}
```

1. Run the builder:

```sh
dart run build_runner build
# or
dart run build_runner watch --delete-conflicting-outputs
```

1. Inspect outputs:

- Per-library JSON files with suffix: `.feather_widget_meta.json`
- A combined JSON manifest containing all discovered entries

## Links

- Annotations: `packages/feather_core`
- Repository: [github.com/AbhijithKonnayil/feather](https://github.com/AbhijithKonnayil/feather)

<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# feather_core

Core primitives, models, enums, and utilities that power the Feather ecosystem. This package is a pure Dart library and is consumed by packages such as `feather_ui`, `feather_generator`, `feather_cli`, and the catalog website.

- Tech: Dart library (SDK ^3.8)
- Repo: [github.com/AbhijithKonnayil/feather](https://github.com/AbhijithKonnayil/feather/tree/main/packages/feather_core)

## Features

- Widget metadata annotations to describe pages, blocks, and components.
- Strongly-typed enums for scopes, types, and categories.
- Models for file and widget metadata serialization.
- File and project utilities (detect Flutter projects, find project root, safe file creation) with structured logging.

## Install

Add to your Dart/Flutter package:

```yaml
dependencies:
  feather_core: any
```

Then import it:

```dart
import 'package:feather_core/feather_core.dart';
```

## Usage

### 1) Describe components with annotations

Use the provided metadata annotations to describe pages, blocks, and components. These are used by generators and registries to index and scaffold UI.

```dart
import 'package:feather_core/feather_core.dart';

@ComponentMeta(
  id: 'feather_btn_01',
  name: 'Feather Button',
  description: 'A Feather demo button.',
  types: [ComponentType.interactive],
  categories: [ComponentCategory.button],
  screens: [Screens.mobile, Screens.desktop],
)
class FeatherButton extends StatelessWidget {}
```

See: `lib/src/annotations/widget_annotations.dart`

## Contributing

Contributions are welcome! Please see the root repository’s [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines.

## License

This package is released under the MIT License. See the root [LICENSE](../../LICENSE).

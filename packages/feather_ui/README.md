# feather_ui

Feather's UI component library for Flutter. Provides reusable widgets for components, blocks and pages

- Tech: Flutter package (SDK ^3.8)

## Install

Add to your Flutter app or package:

```yaml
dependencies:
  feather_ui: any
```

Then import it:

```dart
import 'package:feather_ui/feather_ui.dart';
```

## Usage

Components are organized by scope:

- `page/` — Page-level building blocks
- `block/` — Intermediate layout/sections
- `component/` — Leaf-level reusable widgets

## Code Generation

Feather supports describing widgets with annotations from `feather_core`, and generating metadata/artifacts via `feather_generator`.
If you want to enable generators in your app/package:

```yaml
dev_dependencies:
  build_runner: ^2.8.0
  feather_generator: any
```

Run:

```sh
melos update_widgets
```

Generated files may appear under `_generated/` or with the suffix `.feather_widget_meta.json` depending on configured builders.

## Folder Structure

```text
lib/
├── page/           # Page-level components
├── block/          # Section/Block-level components
├── component/      # Leaf-level UI components
├── _generated/     # Generated sources (if applicable)
└── feather_ui.dart
```

## Links

- Core library: `packages/feather_core`
- Generator: `packages/feather_generator`
- Repository: [github.com/AbhijithKonnayil/feather](https://github.com/AbhijithKonnayil/feather)

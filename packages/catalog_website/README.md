# Catalog Website

Interactive component catalog for Feather, built with Flutter Web. Browse components, blocks, and pages with live previews.

- Tech: Flutter Web
- Libraries: Widgetbook, BLoC, GoRouter, Google Fonts
- Depends on: `feather_ui`, `feather_core`

## Prerequisites

- Flutter SDK (3.x)
- Chrome (for web development)

## Run (Web - Chrome)

```sh
flutter run -d chrome
```

## Build (Web)

```sh
flutter build web
```

The production build is output to `build/web/`.

## Project Structure

```text
packages/catalog_website/
├── lib/                # Application source
├── assets/             # Images and static assets
├── web/                # Web entry
├── android/ ios/ macos/ linux/ windows/  # Platforms
└── pubspec.yaml        # Dependencies and Flutter config
```

## Links

- UI components: `packages/feather_ui`
- Core models/annotations: `packages/feather_core`
- Repository: [github.com/AbhijithKonnayil/feather](https://github.com/AbhijithKonnayil/feather)

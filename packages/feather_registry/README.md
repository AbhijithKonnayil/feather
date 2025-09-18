# feather_registry

Central registry for Feather components, blocks, and pages. This package aggregates machine-readable metadata (JSON) used by the CLI and documentation tools.

- Tech: Dart library (SDK ^3.9)
- Consumed by: `feather_cli` (to install/download files) and catalog tooling

## Overview

The registry hosts metadata describing UI entries (IDs, names, descriptions, categories, screens, and associated files/targets). Metadata is typically generated from annotations in source packages using `feather_generator` and then published here for consumers.

## How It’s Used

- `feather_cli` reads the registry to locate components and download their files into an application codebase.
- The catalog website can ingest the same metadata to display and preview components.

## Contributing Entries

1. Annotate your widgets using `feather_core` annotations (e.g., `ComponentMeta`).
1. Generate metadata using `feather_generator` via `build_runner`.
1. Contribute the resulting JSON to this registry package (under `lib/_generated/`).

Please follow the repository’s [CONTRIBUTING.md](../../CONTRIBUTING.md) for review and validation steps.

## Optional: Install as a Dependency

If you need to access registry assets programmatically from Dart:

```yaml
dependencies:
  feather_registry: any
```

Then import it and load assets/files as needed.

## Structure

```text
packages/feather_registry/
└── lib/
    └── _generated/      # Registry JSON artifacts
```

## Links

- Core annotations: `packages/feather_core`
- CLI: `packages/feather_cli`
- Repository: [github.com/AbhijithKonnayil/feather](https://github.com/AbhijithKonnayil/feather)

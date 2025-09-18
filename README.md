![Feather Logo](assets/feather_brand.png)

# Feather

A modern, open-source **Flutter component library** with a focus on speed, simplicity, and consistency.  

---

## 🚀 Features

---

## 📦 Repository Structure

```text
feather/
├── assets/
│   ├── feather_brand.png
│   └── feather_logo.png
├── packages/
│   ├── feather_core/          # Core primitives and shared utilities
│   ├── feather_ui/            # UI components library 
│   ├── feather_registry/      # Component registry, metadata, and tokens
│   ├── feather_generator/     # Code generation for components and docs
│   ├── feather_cli/           # Command-line toolkit for installing UI into apps and assisting contributions
│   ├── feather_example/       # Example Flutter app showcasing usage
│   ├── catalog_website/       # Flutter-based component catalog (docs)
│   └── website/               # Official Feather Website
├── build/                     # Build artifacts (generated)
├── pubspec.yaml               # Root Dart workspace configuration
├── LICENSE
└── README.md
```

Note: Some IDE or environment files (e.g., `*.iml`) and build outputs are
generated and may not be relevant to contributors.
## 📦 Packages

| Package            | Description                                                        | Tech Stack                                      | Docs |
|--------------------|--------------------------------------------------------------------|------------------------------------------------|------|
| **feather_core**   | Core primitives and shared utilities                               | Dart library (SDK ^3.8)                        | [README](packages/feather_core/README.md) |
| **feather_ui**     | UI components library (built on `feather_core`)                    | Flutter package (SDK ^3.8), build_runner + custom generator | [README](packages/feather_ui/README.md) |
| **feather_registry** | Component registry, metadata, and tokens                          | Dart library (SDK ^3.9)                        | [README](packages/feather_registry/README.md) |
| **feather_generator** | Code generation for components and docs                         | Dart builder/source_gen (analyzer, build, source_gen) | [README](packages/feather_generator/README.md) |
| **feather_cli**    | Command-line toolkit for installing UI into apps & assisting contributions | Dart CLI (args, cli_completion, mason_logger) | [README](packages/feather_cli/README.md) |
| **feather_example**| Example Flutter app showcasing usage                               | Flutter app                                    | [README](packages/feather_example/README.md) |
| **catalog_website**| Interactive component catalog (docs)                               | Flutter Web app (Widgetbook, BLoC, GoRouter)   | [README](packages/catalog_website/README.md) |
| **website**        | Official Feather website (landing + docs)                          | React 19 + TypeScript + Vite                   | [README](packages/website/README.md) |

---

## 🤝 Contributing
Feather is open-source!  
We welcome contributors to add new components, improve documentation, or enhance the tooling.  

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📜 License
Feather is licensed under the **MIT License** – free to use, modify, and distribute.

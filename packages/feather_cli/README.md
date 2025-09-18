# feather_cli

A command-line toolkit to install Feather UI components into your apps and assist contributions.

- Executable: `feather_cli`
- Tech: Dart CLI (args, cli_completion, mason_logger)

## Getting Started 🚀

Install globally from pub (when published):

```sh
dart pub global activate feather_cli
```

Install locally from source:

```sh
dart pub global activate --source=path <path-to-this-package>
```

Ensure your global pub bin is on PATH. On Linux/macOS:

```sh
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

## Usage

Global flags:

- `--version`, `-v` — Print the current version
- `--verbose` — Enable verbose logging

Commands:

```sh
# Add a component by name from the registry
feather_cli add <component_name>

# Check for and install updates to feather_cli
feather_cli update

# Developer utilities (internal)
feather_cli dev --help

# Version and help
feather_cli --version
feather_cli --help
```

### Shell Completion

`feather_cli` supports shell completion via `cli_completion`.

```sh
# Bash/Zsh (temporary for current shell)
eval "$(feather_cli completion)"

# To make it persistent, add the above line to your shell profile (e.g., ~/.bashrc or ~/.zshrc)
```

## Troubleshooting

- If `feather_cli` is not found, ensure your pub global bin directory is on PATH.
- Run with `--verbose` to see detailed logs and executed commands.

## Running Tests with Coverage 🧪

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

Generate and view HTML report with [lcov](https://github.com/linux-test-project/lcov):

```sh
genhtml coverage/lcov.info -o coverage/
xdg-open coverage/index.html || open coverage/index.html
```

## Links

- Repository: [github.com/AbhijithKonnayil/feather](https://github.com/AbhijithKonnayil/feather)

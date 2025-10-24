import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_completion/cli_completion.dart';
import 'package:feather_cli/src/commands/commands.dart';
import 'package:feather_cli/src/commands/dev/dev_command.dart';
import 'package:feather_cli/src/version.dart';
import 'package:feather_core/feather_core.dart';
import 'package:pub_updater/pub_updater.dart';

const executableName = 'feather_cli';
const packageName = 'feather_cli';
const description = 'A Very Good Project created by Very Good CLI.';

/// {@template feather_cli_command_runner}
/// A [CommandRunner] for the CLI.
///
/// ```bash
/// $ feather_cli --version
/// ```
/// {@endtemplate}
class FeatherCliCommandRunner extends CompletionCommandRunner<int> {
  /// {@macro feather_cli_command_runner}
  FeatherCliCommandRunner({FConsoleLogger? logger, PubUpdater? pubUpdater})
    : _logger = logger ?? FConsoleLogger(),
      _pubUpdater = pubUpdater ?? PubUpdater(),
      super(executableName, description) {
    // Add root options and flags
    argParser
      ..addFlag(
        'version',
        abbr: 'v',
        negatable: false,
        help: 'Print the current version.',
      )
      ..addFlag(
        'verbose',
        help: 'Noisy logging, including all shell commands executed.',
      );

    // Add sub commands
    addCommand(AddCommand(logger: _logger));
    addCommand(UpdateCommand(logger: _logger, pubUpdater: _pubUpdater));
    addCommand(DevCommand(logger: _logger));
  }

  @override
  void printUsage() => _logger.info(usage);

  final FConsoleLogger _logger;
  final PubUpdater _pubUpdater;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final topLevelResults = parse(args);
      if (topLevelResults['verbose'] == true) {

        _logger.setLogLevel(Level.verbose);
      }
      return await runCommand(topLevelResults) ?? ExitCode.success.code;
    } on FormatException catch (e, stackTrace) {
      // On format errors, show the commands error message, root usage and
      // exit with an error code
      _logger
        ..error(e.message)
        ..error('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      // On usage errors, show the commands usage message and
      // exit with an error code
      _logger
        ..error(e.message)
        ..info('')
        ..info(e.usage);
      return ExitCode.usage.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    // Fast track completion command
    if (topLevelResults.command?.name == 'completion') {
      await super.runCommand(topLevelResults);
      return ExitCode.success.code;
    }

    // Verbose logs
    _logger
      ..debug('Argument information:')
      ..debug('  Top level options:');
    for (final option in topLevelResults.options) {
      if (topLevelResults.wasParsed(option)) {
        _logger.debug('  - $option: ${topLevelResults[option]}');
      }
    }
    if (topLevelResults.command != null) {
      final commandResult = topLevelResults.command!;
      _logger
        ..debug('  Command: ${commandResult.name}')
        ..debug('    Command options:');
      for (final option in commandResult.options) {
        if (commandResult.wasParsed(option)) {
          _logger.debug('    - $option: ${commandResult[option]}');
        }
      }
    }

    // Run the command or show version
    final int? exitCode;
    if (topLevelResults['version'] == true) {
      _logger.info(packageVersion);
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }

    // Check for updates
    if (topLevelResults.command?.name != UpdateCommand.commandName) {
      await _checkForUpdates();
    }

    return exitCode;
  }

  /// Checks if the current version (set by the build runner on the
  /// version.dart file) is the most recent one. If not, show a prompt to the
  /// user.
  Future<void> _checkForUpdates() async {
    try {
      final latestVersion = await _pubUpdater.getLatestVersion(packageName);
      final isUpToDate = packageVersion == latestVersion;
      if (!isUpToDate) {
        _logger
          ..info('')
          ..info('''
${lightYellow.wrap('Update available!')} ${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}
Run ${lightCyan.wrap('$executableName update')} to update''');
      }
    } on Exception catch (_) {
      _logger.error('Failed to check for updates.');
    }
  }
}

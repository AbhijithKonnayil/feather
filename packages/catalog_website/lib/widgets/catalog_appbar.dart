import 'package:catalog_website/providers/theme_provider.dart';
import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class CatalogAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CatalogAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final themeNotifier = ref.read(themeProvider.notifier);
    final selectedScope = ref.watch(selectedScopeProvider);
    print(selectedScope);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppBar(
          title: Image.asset(
            'assets/images/feather_logo.png',
            fit: BoxFit.contain,
            height: 40,
          ),
          toolbarHeight: 50,
          actions: [
            ...WidgetScope.values.map((scope) {
              print("$scope $selectedScope ${scope == selectedScope}");
              return MaterialButton(
                onPressed: () =>
                    ref.read(selectedScopeProvider.notifier).changeScope(scope),
                child: Container(
                  color: selectedScope == scope ? Colors.blue : Colors.grey,
                  child: Text(scope.name),
                ),
              );
            }).toList(),
            // Dark mode toggle
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => themeNotifier.toggleTheme(),
              tooltip: isDarkMode
                  ? 'Switch to Light Mode'
                  : 'Switch to Dark Mode',
            ),
            // GitHub icon
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: () => launchUrl(
                Uri.parse('https://github.com/AbhijithKonnayil/feather'),
                mode: LaunchMode.externalApplication,
              ),
              tooltip: 'View on GitHub',
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight + 16);
}

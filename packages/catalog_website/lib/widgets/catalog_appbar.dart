import 'package:catalog_website/providers/theme_provider.dart';
import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ScopeTab extends ConsumerWidget {
  const ScopeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScope = ref.watch(selectedScopeProvider);

    return Row(
      children: [
        ...WidgetScope.values.map((e) {
          final isSelected = selectedScope == e;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      ref.read(selectedScopeProvider.notifier).changeScope(e);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        e.name.toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 3,
                  width: 24,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class CatalogAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CatalogAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final themeNotifier = ref.read(themeProvider.notifier);
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Image.asset(
            'assets/images/feather_logo.png',
            fit: BoxFit.contain,
            height: 40,
          ),
          toolbarHeight: 50,
          actions: [
            const SizedBox(width: 8),

            ScopeTab(),
            const SizedBox(width: 8),
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
  Size get preferredSize => const Size(double.infinity, kToolbarHeight + 20);
}

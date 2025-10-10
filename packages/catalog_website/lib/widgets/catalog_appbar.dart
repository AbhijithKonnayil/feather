import 'package:catalog_website/providers/search_provider.dart';
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
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            Row(
              spacing: 10,
              children: [
                ScopeTab(),
                WidgetSearchbar(),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight + 20);
}

class WidgetSearchbar extends ConsumerStatefulWidget {
  const WidgetSearchbar({super.key});

  @override
  ConsumerState<WidgetSearchbar> createState() => _WidgetSearchbarState();
}

class _WidgetSearchbarState extends ConsumerState<WidgetSearchbar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(searchQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchQueryNotifier = ref.read(searchQueryProvider.notifier);

    // Listen inside build (valid in Riverpod 3.x)
    ref.listen<String>(searchQueryProvider, (prev, next) {
      if (_controller.text != next) {
        _controller.text = next;
      }
    });

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: TextField(
        controller: _controller,
        onChanged: (value) => searchQueryNotifier.updateQuery(value),
        decoration: InputDecoration(
          hintText: 'Search widgets...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () => searchQueryNotifier.updateQuery(''),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

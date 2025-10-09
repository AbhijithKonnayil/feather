import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/theme_provider.dart' show themeProvider;

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const CatalogAppbar());
  }
}

class CatalogAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CatalogAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final themeNotifier = ref.read(themeProvider.notifier);

    return AppBar(
      title: Image.asset(
        'assets/images/feather_brand.png',
        fit: BoxFit.contain,
        height: 40,
      ),
      toolbarHeight: 50,
      actions: [
        // Dark mode toggle
        IconButton(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          onPressed: () => themeNotifier.toggleTheme(),
          tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
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
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

import 'package:catalog_website/providers/theme_provider.dart';
import 'package:catalog_website/widgets/scope_tab.dart';
import 'package:catalog_website/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Row(
            children: [
              Image.asset(
                'assets/images/feather_logo.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              Text(
                "Feather",
                style: GoogleFonts.alexBrush(
                  fontSize: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: 5),
              Text("0.0.3", style: TextStyle(fontSize: 10)),
            ],
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

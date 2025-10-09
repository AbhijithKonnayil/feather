import 'package:catalog_website/core/locator.dart';
import 'package:catalog_website/core/router.dart';
import 'package:catalog_website/providers/theme_provider.dart';
import 'package:catalog_website/theme/feather_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setupLocator();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Feather Catalog',
      routerConfig: router,
      theme: FeatherTheme.lightTheme,
      darkTheme: FeatherTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

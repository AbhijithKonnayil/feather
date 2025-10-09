import 'package:catalog_website/core/locator.dart';
import 'package:catalog_website/core/router.dart';
import 'package:catalog_website/theme/feather_theme.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: featherTheme,
      darkTheme: featherDarkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

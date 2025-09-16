import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/catalog'),
              child: const Text("Go to Catalog (Home)"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/widgetbook'),
              child: const Text("Go to Widgetbook"),
            ),
          ],
        ),
      ),
    );
  }
}

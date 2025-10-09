import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:catalog_website/widgets/catalog_appbar.dart';
import 'package:catalog_website/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredWidgets = ref.watch(filteredWidgetsProvider);
    print(filteredWidgets);
    return Scaffold(
      appBar: const CatalogAppbar(),
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: GridView.builder(
              itemCount: filteredWidgets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.red,
                  child: Center(child: Text(filteredWidgets[index].name)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

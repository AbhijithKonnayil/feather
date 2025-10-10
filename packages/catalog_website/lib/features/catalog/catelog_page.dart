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
    final selectedWidget = ref.watch(selectedWidgetProvider);
    return Scaffold(
      appBar: const CatalogAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Sidebar(),
            Expanded(
              child: GridView.builder(
                itemCount: filteredWidgets.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedWidgetProvider.notifier)
                          .toggleWidget(filteredWidgets[index]),
                      child: Card(
                        color: Colors.red,
                        child: Center(child: Text(filteredWidgets[index].name)),
                      ),
                    ),
                  );
                },
              ),
            ),
            AnimatedContainer(
              color: Colors.green,
              duration: Duration(milliseconds: 300),
              width: selectedWidget == null
                  ? 0
                  : MediaQuery.of(context).size.width * 0.5,
              child: selectedWidget == null
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.all(8.0),
                      height: double.infinity,
                      width: double.infinity,
                      child: selectedWidget.example(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

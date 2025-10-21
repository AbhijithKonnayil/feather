import 'package:catalog_website/widgets/catalog_appbar.dart';
import 'package:catalog_website/widgets/sidebar.dart';
import 'package:catalog_website/widgets/widget_grid.dart';
import 'package:catalog_website/widgets/widget_preview_sidepanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final selectedWidget = ref.watch(selectedWidgetProvider);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: WidgetPreviewSidePanel(),
      appBar: const CatalogAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Sidebar(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: WidgetGrid(),
              ),
            ),

            /*  AnimatedContainer(
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
                      child: WidgetPreviewSidePanel(
                        widgetDetails: selectedWidget,
                      ),
                    ),
            ), */
          ],
        ),
      ),
    );
  }
}

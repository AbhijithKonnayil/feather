import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:catalog_website/widgets/grid_card.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WidgetGrid extends ConsumerWidget {
  const WidgetGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredWidgets = ref.watch(filteredWidgetsProvider);
    if (filteredWidgets.isEmpty) {
      return SizedBox(
        height: 500,
        child: Image.asset('assets/images/no_items.png'),
      );
    }

    return MasonryGridView.count(
      padding: EdgeInsets.all(0),
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: filteredWidgets.length,
      itemBuilder: (context, index) {
        final item = filteredWidgets[index];
        String? previewImageDevice;
        double? aspectRatio;
        if (item.screens.contains(Screens.mobile)) {
          aspectRatio = 9 / 16;
          previewImageDevice = 'mobile';
        } else if (item.screens.contains(Screens.tablet)) {
          aspectRatio = 3 / 4;
          previewImageDevice = 'tablet';
        } else if (item.screens.contains(Screens.desktop)) {
          aspectRatio = 16 / 9;
          previewImageDevice = 'desktop';
        }
        return GridCard(item: item);
      },
    );
  }
}

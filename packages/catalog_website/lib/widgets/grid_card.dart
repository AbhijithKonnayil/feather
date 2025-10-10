import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridCard extends ConsumerWidget {
  const GridCard({super.key, required this.item});
  final WidgetDetails item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    String? previewImageDevice;
    double aspectRatio = 1;
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
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.topCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ref.read(selectedWidgetProvider.notifier).toggleWidget(item);
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(item.name, style: theme.textTheme.titleLarge),
              // Row(children: [...item.screens.map((e) => Text(e.label))]),
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Container(
                  color: Colors.red,
                  child: Image.asset(
                    "assets/screenshots/${item.id.toLowerCase()}_$previewImageDevice.jpeg",
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

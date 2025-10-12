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
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      elevation: 0,
      shape: _buildCardShape(colorScheme),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            ref.read(selectedWidgetProvider.notifier).toggleWidget(item),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPreviewSection(context, colorScheme, textTheme),
            _buildContentSection(context, colorScheme, textTheme),
          ],
        ),
      ),
    );
  }

  /// Builds the preview section with device frame and image
  Widget _buildPreviewSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final previewImageDevice = _getPreviewDevice();
    final aspectRatio = _getAspectRatio(previewImageDevice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview image container
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: _buildPreviewImage(
                  context,
                  previewImageDevice,
                  colorScheme,
                  textTheme,
                ),
              ),
            ),
          ),
        ),
        // Device info bar
        _buildDeviceInfoBar(colorScheme, textTheme),
      ],
    );
  }

  /// Builds the main content section with title and description
  Widget _buildContentSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(colorScheme, textTheme),
          if (item.description.isNotEmpty)
            _buildDescription(colorScheme, textTheme),
        
        ],
      ),
    );
  }

  /// Builds the preview image with error handling
  Widget _buildPreviewImage(
    BuildContext context,
    String device,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          "assets/screenshots/${item.id.toLowerCase()}_$device.jpeg",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildErrorState(context, textTheme, colorScheme),
        ),
      ),
    );
  }

  /// Builds the device info bar with device type indicators
  Widget _buildDeviceInfoBar(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Wrap(
        spacing: 2,
        runSpacing: 5,
        children: item.screens
            .map((screen) => _buildDeviceChip(screen, colorScheme, textTheme))
            .toList(),
      ),
    );
  }

  /// Builds an individual device chip
  Widget _buildDeviceChip(
    Screens screen,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDeviceIcon(screen, colorScheme),
          const SizedBox(width: 4),
          _buildDeviceLabel(screen, textTheme, colorScheme),
        ],
      ),
    );
  }

  /// Builds the device icon based on screen type
  Widget _buildDeviceIcon(Screens screen, ColorScheme colorScheme) {
    return Icon(_getDeviceIcon(screen), size: 14, color: colorScheme.primary);
  }

  /// Returns the appropriate icon for the device type
  IconData _getDeviceIcon(Screens screen) {
    switch (screen) {
      case Screens.mobile:
        return Icons.phone_android;
      case Screens.tablet:
        return Icons.tablet_android;
      case Screens.desktop:
        return Icons.desktop_windows;
    }
  }

  /// Builds the device label text
  Widget _buildDeviceLabel(
    Screens screen,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Text(
      screen.name.toUpperCase(),
      style: textTheme.labelSmall?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Builds the widget title
  Widget _buildTitle(ColorScheme colorScheme, TextTheme textTheme) {
    return Text(
      item.name,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the widget description
  Widget _buildDescription(ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          item.description,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  /// Builds the categories section
  Widget _buildCategories(ColorScheme colorScheme, TextTheme textTheme) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: item.categories
          .take(3)
          .map(
            (category) => _buildCategoryChip(category, colorScheme, textTheme),
          )
          .toList(),
    );
  }

  /// Builds an individual category chip
  Widget _buildCategoryChip(
    dynamic category,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category.toString().split('.').last,
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Builds the card's shape with rounded corners and border
  ShapeBorder _buildCardShape(ColorScheme colorScheme) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: colorScheme.outlineVariant.withOpacity(0.1),
        width: 1,
      ),
    );
  }

  /// Returns the preview device based on available screens
  String _getPreviewDevice() {
    if (item.screens.contains(Screens.mobile)) return 'mobile';
    if (item.screens.contains(Screens.tablet)) return 'tablet';
    return 'desktop';
  }

  /// Returns the aspect ratio for the given device type
  double _getAspectRatio(String device) {
    switch (device) {
      case 'mobile':
        return 9 / 16;
      case 'tablet':
        return 3 / 4;
      default:
        return 16 / 9;
    }
  }

  /// Builds the error state widget
  Widget _buildErrorState(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 40,
            color: colorScheme.onSurfaceVariant.withOpacity(0.3),
          ),
          const SizedBox(height: 8),
          Text(
            'Preview not available',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

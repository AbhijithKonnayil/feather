import 'package:catalog_website/core/screen_meta.dart';
import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:catalog_website/widgets/generic_tab_bar.dart';
import 'package:catalog_website/widgets/text_button.dart';
import 'package:device_preview/device_preview.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WidgetPreviewSidePanel extends ConsumerStatefulWidget {
  //final WidgetDetails? widgetDetails;
  const WidgetPreviewSidePanel({super.key});

  @override
  ConsumerState<WidgetPreviewSidePanel> createState() =>
      _WidgetPreviewSidePanelState();
}

class _WidgetPreviewSidePanelState
    extends ConsumerState<WidgetPreviewSidePanel> {
  Screens? selectedScreen;
  bool _isCopied = false;

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    setState(() => _isCopied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isCopied = false);
    }
  }

  Screens getSelectedScreen() {
    return selectedScreen ?? ref.watch(selectedWidgetProvider)!.screens.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // final details = widget.widgetDetails;
    final details = ref.watch(selectedWidgetProvider);
    print("details $details");
    if (details == null) {
      return Container();
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(theme, details),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Divider(height: 1, thickness: 0.5),
          ),
          _buildScreenTabs(theme, details),
          _buildPreviewArea(theme, details),
          _buildMetadataSection(theme, details),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, WidgetDetails details) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                details.name,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                details.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
          Spacer(),
          FTextButton(
            label: "View",
            onPressed: () {
              context.push("/widget-preview", extra: details);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScreenTabs(ThemeData theme, WidgetDetails details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: GenericTabBar<Screens>(
        items: details.screens,
        initialValue: getSelectedScreen(),
        onItemSelected: (screen) => setState(() => selectedScreen = screen),
        labelBuilder: (screen) => screen.name.toUpperCase(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildPreviewArea(ThemeData theme, WidgetDetails details) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: DeviceFrame(
            device: ScreenMeta.getPreviewDeviceInfo(getSelectedScreen()),
            screen: Container(
              color: Colors.white,
              child: Image.asset(
                details.getScreenshotPath(getSelectedScreen()),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPreviewError(textTheme, colorScheme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewError(TextTheme textTheme, ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'Preview not available',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataSection(ThemeData theme, WidgetDetails details) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (details.types.isNotEmpty)
            ..._buildMetadataSectionItems(
              context,
              title: 'Types',
              items: details.types.map((e) => e.label).toList(),
              icon: Icons.category_outlined,
            ),

          if (details.categories.isNotEmpty)
            ..._buildMetadataSectionItems(
              context,
              title: 'Categories',
              items: details.categories.map((e) => e.label).toList(),
              icon: Icons.label_outline,
            ),

          _buildInstallationSection(theme, details.installCommand),
        ],
      ),
    );
  }

  Widget _buildInstallationSection(ThemeData theme, String installCommand) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          'Installation',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _copyToClipboard(installCommand);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Copied to clipboard')));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.outlineVariant, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    installCommand,
                    style: textTheme.bodyMedium?.copyWith(
                      fontFamily: 'RobotoMono',
                      color: colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _isCopied ? Icons.check : Icons.copy,
                  size: 18,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildMetadataSectionItems(
    BuildContext context, {
    required String title,
    required List<String> items,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return [
      const SizedBox(height: 4),
      Row(
        children: [
          Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items.map((item) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorScheme.outlineVariant, width: 1),
            ),
            child: Text(
              item,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 12),
    ];
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:catalog_website/core/screen_meta.dart';
import 'package:catalog_website/widgets/screenshot_widget.dart';
import 'package:catalog_website/widgets/text_button.dart';
import 'package:device_preview/device_preview.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

final Map<Screens, List<DeviceInfo>> deviceInfos = {
  Screens.desktop: [
    DeviceInfo.genericDesktopMonitor(
      platform: TargetPlatform.windows,
      id: 'windows_desktop_large',
      name: 'Windows Desktop (Large)',
      screenSize: const Size(1920, 1080),
      windowPosition: const Rect.fromLTWH(0, 0, 1920, 1080),
    ),
    DeviceInfo.genericDesktopMonitor(
      platform: TargetPlatform.windows,
      id: 'windows_desktop_small',
      name: 'Windows Desktop (Small)',
      screenSize: const Size(1366, 768),
      windowPosition: const Rect.fromLTWH(0, 0, 1366, 768),
    ),
    DeviceInfo.genericDesktopMonitor(
      platform: TargetPlatform.macOS,
      id: 'macbook_pro',
      name: 'MacBook Pro',
      screenSize: const Size(1728 / 2, 1117 / 2),
      windowPosition: const Rect.fromLTWH(0, 0, 1728 / 2, 1117 / 2),
    ),
  ],
  Screens.tablet: [
    DeviceInfo.genericTablet(
      platform: TargetPlatform.iOS,
      id: 'ipad_pro_12.9',
      name: 'iPad Pro 12.9"',
      pixelRatio: 2.0,
      screenSize: const Size(1024, 1366),
      safeAreas: const EdgeInsets.only(top: 24, bottom: 20),
    ),
    DeviceInfo.genericTablet(
      platform: TargetPlatform.iOS,
      id: 'ipad_mini_6',
      name: 'iPad Mini 6',
      pixelRatio: 2.0,
      screenSize: const Size(744, 1133),
      safeAreas: const EdgeInsets.only(top: 24, bottom: 20),
    ),
    DeviceInfo.genericTablet(
      platform: TargetPlatform.android,
      id: 'android_tablet_10',
      name: 'Android Tablet 10"',
      pixelRatio: 2.0,
      screenSize: const Size(800, 1280),
      safeAreas: const EdgeInsets.only(top: 24, bottom: 24),
    ),
  ],
  Screens.mobile: [
    DeviceInfo.genericPhone(
      platform: TargetPlatform.android,
      id: 'google_pixel_7',
      name: 'Google Pixel 7',
      pixelRatio: 2.625,
      screenSize: const Size(1080 / 2.625, 2400 / 2.625),
      safeAreas: const EdgeInsets.only(top: 48, bottom: 34),
    ),
    DeviceInfo.genericPhone(
      platform: TargetPlatform.android,
      id: 'samsung_galaxy_s23',
      name: 'Samsung Galaxy S23',
      pixelRatio: 3.0,
      screenSize: const Size(1080 / 3, 2340 / 3),
      safeAreas: const EdgeInsets.only(top: 44, bottom: 34),
    ),

    // iOS Devices
    DeviceInfo.genericPhone(
      platform: TargetPlatform.iOS,
      id: 'iphone_14_pro_max',
      name: 'iPhone 14 Pro Max',
      pixelRatio: 3.0,
      screenSize: const Size(430, 932),
      safeAreas: const EdgeInsets.only(top: 47, bottom: 34),
    ),
    DeviceInfo.genericPhone(
      platform: TargetPlatform.iOS,
      id: 'iphone_14',
      name: 'iPhone 14',
      pixelRatio: 3.0,
      screenSize: const Size(390, 844),
      safeAreas: const EdgeInsets.only(top: 47, bottom: 34),
    ),
    DeviceInfo.genericPhone(
      platform: TargetPlatform.iOS,
      id: 'iphone_se_3rd_gen',
      name: 'iPhone SE (3rd Gen)',
      pixelRatio: 2.0,
      screenSize: const Size(375, 667),
      safeAreas: const EdgeInsets.only(top: 20, bottom: 0),
    ),
  ],
};

class WidgetPreviewPage extends StatelessWidget {
  final WidgetDetails widgetDetails;
  WidgetPreviewPage({super.key, required this.widgetDetails});
  List<DeviceInfo> get displayedDevices => [...DevicePreview.defaultDevices];
  final ScreenshotController screenshotController = ScreenshotController();
  final FAppLogger logger = FAppLogger();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(widgetDetails.name),
        actions: [
          FTextButton(
            onPressed: () {
              screenshotController.capture();
            },
            label: "Screen Shot",
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: DevicePreview(
          backgroundColor: theme.scaffoldBackgroundColor,
          tools: [...DevicePreview.defaultTools],
          devices: [
            if (widgetDetails.screens.contains(Screens.desktop))
              ...[
                ScreenMeta.getPreviewDeviceInfo(Screens.desktop),
                ...displayedDevices,
              ].where((device) => device.identifier.type == DeviceType.desktop),
            if (widgetDetails.screens.contains(Screens.tablet))
              ...[
                ScreenMeta.getPreviewDeviceInfo(Screens.tablet),
                ...displayedDevices,
              ].where((device) => device.identifier.type == DeviceType.tablet),
            if (widgetDetails.screens.contains(Screens.mobile))
              ...[
                ScreenMeta.getPreviewDeviceInfo(Screens.mobile),
                ...displayedDevices,
              ].where((device) => device.identifier.type == DeviceType.phone),
          ],
          builder: (context) {
            final device = DevicePreview.selectedDevice(context);
            final screen = device.identifier.type == DeviceType.desktop
                ? Screens.desktop
                : device.identifier.type == DeviceType.tablet
                ? Screens.tablet
                : Screens.mobile;
            return ScreenshotCaptureWidget(
              fileName: widgetDetails.name,
              child: widgetDetails.example(),
              controller: screenshotController,
              onScreenshot: (bytes) async {
                try {
                  await saveScreenshotWebWasm(
                    bytes: bytes,
                    fileName: widgetDetails.getScreenshotFilename(screen),
                  );
                } catch (e) {
                  logger.error(e.toString());
                }
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> saveScreenshotWebWasm({
    required Uint8List bytes,
    required String fileName,
  }) async {
    try {
      // Ensure filename has an image extension
      final normalizedName = fileName.toLowerCase().endsWith('.png')
          ? fileName
          : '$fileName.png';

      // Build a data URL to avoid Blob/typed array interop issues
      final dataUrl = 'data:image/png;base64,' + base64Encode(bytes);

      // Create a hidden <a> element for download
      final anchor = web.HTMLAnchorElement()
        ..href = dataUrl
        ..download = normalizedName
        ..style.display = 'none'
        ..rel = 'noopener';

      // Fallback for browsers that ignore download attribute (iOS Safari)
      if (anchor.download.isEmpty) {
        anchor.target = '_blank';
      }

      // Add to document and trigger click
      web.document.body!.appendChild(anchor);
      anchor.click();

      // Clean up
      anchor.remove();

      print('Screenshot saved successfully!');
    } catch (e) {
      print('Error saving screenshot: $e');
    }
  }
}

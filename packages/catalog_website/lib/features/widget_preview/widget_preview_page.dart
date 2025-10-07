import 'package:device_preview/device_preview.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';

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
  const WidgetPreviewPage({super.key, required this.widgetDetails});
  List<DeviceInfo> get defaultDevices => DevicePreview.defaultDevices;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widgetDetails.name)),
      body: Center(
        child: DevicePreview(
          devices: [
            if (widgetDetails.screens.contains(Screens.desktop))
              ...defaultDevices.where(
                (device) => device.identifier.type == DeviceType.desktop,
              ),
            if (widgetDetails.screens.contains(Screens.tablet))
              ...defaultDevices.where(
                (device) => device.identifier.type == DeviceType.tablet,
              ),
            if (widgetDetails.screens.contains(Screens.mobile))
              ...defaultDevices.where(
                (device) => device.identifier.type == DeviceType.phone,
              ),
          ],
          builder: (context) => widgetDetails.example(),
        ),
      ),
    );
  }
}

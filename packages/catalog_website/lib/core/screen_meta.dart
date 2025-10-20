import 'package:device_preview/device_preview.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';

class ScreenMeta {
  final Size size;
  final IconData icon;
  final TargetPlatform platform;

  DeviceInfo Function(ScreenMeta, Screens) deviceInfo;

  ScreenMeta({
    required this.size,
    required this.icon,
    required this.platform,

    required this.deviceInfo,
  });

  double get aspectRatio => size.aspectRatio;
  static final Map<Screens, ScreenMeta> _previewMetaData = {
    Screens.mobile: ScreenMeta(
      size: const Size(360, 800),
      icon: Icons.phone_android,
      platform: TargetPlatform.android,
      deviceInfo: (ScreenMeta meta, Screens screen) => DeviceInfo.genericPhone(
        id: screen.name,
        platform: meta.platform,
        name: "Catalog Preview - ${screen.label}",
        screenSize: meta.size,
        safeAreas: const EdgeInsets.all(0),
      ),
    ),
    Screens.tablet: ScreenMeta(
      size: const Size(1024, 1366),
      icon: Icons.tablet_android,
      platform: TargetPlatform.android,
      deviceInfo: (ScreenMeta meta, Screens screen) => DeviceInfo.genericTablet(
        id: screen.name,
        platform: meta.platform,
        name: "Catalog Preview - ${screen.label}",
        screenSize: meta.size,
        safeAreas: const EdgeInsets.all(0),
      ),
    ),
    Screens.desktop: ScreenMeta(
      size: const Size(1920, 1080),
      icon: Icons.desktop_windows,
      platform: TargetPlatform.windows,
      deviceInfo: (ScreenMeta meta, Screens screen) =>
          DeviceInfo.genericDesktopMonitor(
            id: screen.name,
            platform: meta.platform,
            name: "Catalog Preview - ${screen.label}",
            screenSize: meta.size,
            safeAreas: const EdgeInsets.all(0),
            windowPosition: const Rect.fromLTWH(0, 0, 1920, 1080),
          ),
    ),
  };

  static ScreenMeta getPreviewMeta(Screens screen) => _previewMetaData[screen]!;

  static DeviceInfo getPreviewDeviceInfo(Screens screen) {
    final screenMeta = _previewMetaData[screen];
    return screenMeta!.deviceInfo(screenMeta, screen);
  }
}

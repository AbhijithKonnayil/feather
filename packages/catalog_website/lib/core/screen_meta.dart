import 'package:device_preview/device_preview.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';

import 'preview_sizes.dart';

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
      size: Size(
        previewSizes[Screens.mobile]![0],
        previewSizes[Screens.mobile]![1],
      ),
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
      size: Size(
        previewSizes[Screens.tablet]![0],
        previewSizes[Screens.tablet]![1],
      ),
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
      size: Size(
        previewSizes[Screens.desktop]![0],
        previewSizes[Screens.desktop]![1],
      ),
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

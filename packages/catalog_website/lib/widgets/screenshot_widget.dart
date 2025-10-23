import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A controller that lets you trigger a screenshot from outside the widget.
class ScreenshotController {
  _ScreenshotCaptureWidgetState? _state;

  Future<void> capture() async {
    await _state?._captureScreenshot();
  }
}

class ScreenshotCaptureWidget extends StatefulWidget {
  final Widget child;
  final ScreenshotController controller;
  final String fileName;
  final String? filePath; // Optional custom save path (mobile/desktop only)
  final double pixelRatio;
  final Function(Uint8List) onScreenshot;

  const ScreenshotCaptureWidget({
    super.key,
    required this.child,
    required this.controller,
    this.fileName = 'screenshot.png',
    this.filePath,
    this.pixelRatio = 3.0,
    required this.onScreenshot,
  });

  @override
  State<ScreenshotCaptureWidget> createState() =>
      _ScreenshotCaptureWidgetState();
}

class _ScreenshotCaptureWidgetState extends State<ScreenshotCaptureWidget> {
  final GlobalKey _repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
  }

  @override
  void dispose() {
    widget.controller._state = null;
    super.dispose();
  }

  Future<void> _captureScreenshot() async {
    try {
      RenderRepaintBoundary boundary =
          _repaintKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: widget.pixelRatio);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      widget.onScreenshot(pngBytes);
    } catch (e) {
      debugPrint('Error capturing screenshot: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(key: _repaintKey, child: widget.child);
  }
}

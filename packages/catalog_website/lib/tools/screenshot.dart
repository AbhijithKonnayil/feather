import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:catalog_website/_generated/component.g.dart';
import 'package:feather_core/feather_core.dart';
import 'package:feather_ui/_generated/block.g.dart';
import 'package:feather_ui/_generated/page.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

var files = [];
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final completer = Completer<void>();

  final widgetScope = WidgetScope.values.byName(args.first);
  final widgetId = args[1];

  final scopeMap = {
    WidgetScope.block: blockList,
    WidgetScope.component: componentList,
    WidgetScope.page: pageList,
  };

  final widgetList = scopeMap[widgetScope]!;
  final widget = widgetList.firstWhere((e) => e.id == widgetId);

  runApp(
    ScreenshotWidget(
      widgetDetails: widget,
      onCaptureComplete: () => completer.complete(),
    ),
  );
  await completer.future;
  await doPostCaptureTasks();
  exit(0);
}

Future<void> doPostCaptureTasks() async {
  for (var e in files) {
    final sourceFile = File(e);
    final fileName = p.basename(sourceFile.path);
    final root = FileUtils.findProjectRoot(Directory.current);
    if (root == null) throw InvalidDirectoryException("message");
    final destinationFile = File('${root.path}/assets/screenshots/$fileName');

    await destinationFile.create(recursive: true);

    await sourceFile.copy(destinationFile.path);
    print("file: ${destinationFile.path}");
  }
}

class _ScreenAdapter {
  final GlobalKey globalKey;
  final Size deviceSize;
  _ScreenAdapter({required this.globalKey, required this.deviceSize});
}

class ScreenshotWidget extends StatefulWidget {
  final WidgetDetails widgetDetails;
  final VoidCallback onCaptureComplete;

  const ScreenshotWidget({
    required this.widgetDetails,
    required this.onCaptureComplete,
    super.key,
  });

  @override
  State<ScreenshotWidget> createState() => _ScreenshotWidgetState();
}

class _ScreenshotWidgetState extends State<ScreenshotWidget> {
  @override
  void initState() {
    super.initState();
    _capture();
  }

  late Directory docDir;

  late Directory dir;

  Screens? currentScreen;
  final screenKeyMap = {
    Screens.desktop: _ScreenAdapter(
      globalKey: GlobalKey(),
      deviceSize: const Size(1920, 1080),
    ),
    Screens.mobile: _ScreenAdapter(
      globalKey: GlobalKey(),
      deviceSize: const Size(375, 667),
    ),
    Screens.tablet: _ScreenAdapter(
      globalKey: GlobalKey(),
      deviceSize: const Size(768, 1024),
    ),
  };

  Future<void> _capture() async {
    docDir = await getApplicationDocumentsDirectory();
    dir = Directory('${docDir.path}/feather');

    for (var screen in widget.widgetDetails.screens) {
      setState(() {
        currentScreen = screen;
      });
      await Future.delayed(Duration(seconds: 2));
      await takeScreenshot(
        key: screenKeyMap[currentScreen]!.globalKey,
        widget: widget.widgetDetails,
        screen: screen,
      );
    }
    // exit(0);
    widget.onCaptureComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (currentScreen == null) {
      return Scaffold(body: Center(child: Text("Loading")));
    }
    return MaterialApp(
      home: Center(
        child: RepaintBoundary(
          key: screenKeyMap[currentScreen]!.globalKey,
          child: SizedBox.fromSize(
            size: screenKeyMap[currentScreen]!.deviceSize,
            child: Scaffold(body: widget.widgetDetails.example()),
          ),
        ),
      ),
    );
  }

  Future<void> takeScreenshot({
    required GlobalKey<State<StatefulWidget>> key,
    required WidgetDetails widget,
    required Screens screen,
  }) async {
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    if (!dir.existsSync()) dir.createSync();

    final file = File("${dir.path}/${widget.id}_${screen.name}.jpeg");
    await file.writeAsBytes(bytes);
    files.add(file.absolute.path);
    print("✅ Screenshot saved at ${file.path}");
  }
}

import 'package:catalog_website/features/widget_preview/bloc/widget_preview_bloc.dart';
import 'package:catalog_website/widgets/gradient_tabbar.dart';
import 'package:device_preview/device_preview.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WidgetDisplay extends StatefulWidget {
  const WidgetDisplay({super.key});

  @override
  State<WidgetDisplay> createState() => _WidgetDisplayState();
}

class _WidgetDisplayState extends State<WidgetDisplay>
    with TickerProviderStateMixin {
  TabController? tabController;
  late PageController pageController;
  int? _lastScreensLen;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    tabController?.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetPreviewBloc, WidgetPreviewState>(
      builder: (context, state) {
        if (state is WidgetPreviewLoadedState) {
          final widgetDetails = state.widgetDetails;
          final screens = widgetDetails.screens;

          if (screens.isEmpty) {
            return const SizedBox.shrink();
          }

          if (_lastScreensLen != screens.length || tabController == null) {
            tabController?.dispose();
            tabController = TabController(
              initialIndex: 0,
              length: screens.length,
              vsync: this,
            );
            _lastScreensLen = screens.length;
          }

          return Column(
            children: [
              if (tabController != null)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        IntrinsicWidth(
                          child: GradientTabBar(
                            tabController: tabController!,
                            pageController: pageController,
                            tabs: screens.map((e) => e.label).toList(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.push(
                              '/widget-preview',
                              extra: widgetDetails,
                            );
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: screens.length,
                  onPageChanged: (index) => tabController?.animateTo(index),
                  itemBuilder: (context, index) {
                    final screenType = screens[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: DeviceFrame(
                        device: _deviceFor(screenType),
                        screen: Container(child: widgetDetails.example()),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  DeviceInfo _deviceFor(Screens screen) {
    switch (screen) {
      case Screens.mobile:
        return DeviceInfo.genericPhone(
          platform: TargetPlatform.android,
          id: 'generic_phone',
          name: 'Mobile',
          pixelRatio: 3.0,
          screenSize: const Size(1080 / 3, 2340 / 3),
        );
      case Screens.tablet:
        return DeviceInfo.genericTablet(
          platform: TargetPlatform.android,
          id: 'generic_tablet',
          name: 'Tablet',
          pixelRatio: 2.0,
          screenSize: const Size(2048 / 2, 1536 / 2),
        );
      case Screens.desktop:
        return DeviceInfo.genericLaptop(
          platform: TargetPlatform.windows,
          id: 'generic_laptop',
          name: 'Laptop',
          pixelRatio: 1.5,
          screenSize: const Size(1440, 900),
          windowPosition: Rect.fromCenter(
            center: const Offset(1440 * 0.5, 900 * 0.5),
            width: 1200,
            height: 800,
          ),
        );
    }
  }
}

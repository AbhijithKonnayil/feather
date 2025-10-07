import 'package:catalog_website/features/catalog/catelog_page.dart';
import 'package:catalog_website/features/widget_preview/widget_preview_page.dart';
import 'package:feather_core/feather_core.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    // GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/', builder: (context, state) => const CatalogPage()),
    GoRoute(
      path: '/widget-preview',
      builder: (context, state) =>
          WidgetPreviewPage(widgetDetails: state.extra as WidgetDetails),
    ),
    // GoRoute(path: '/widgetbook', builder: (context, state) => WidgetbookApp()),
  ],
);

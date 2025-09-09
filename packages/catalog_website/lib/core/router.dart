import 'package:catalog_website/features/catalog/catelog_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    // GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/', builder: (context, state) => const CatalogPage()),
    // GoRoute(path: '/widgetbook', builder: (context, state) => WidgetbookApp()),
  ],
);

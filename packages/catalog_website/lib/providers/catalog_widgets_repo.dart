import 'package:catalog_website/_generated/block.g.dart';
import 'package:catalog_website/_generated/component.g.dart';
import 'package:catalog_website/_generated/page.g.dart';
import 'package:feather_core/feather_core.dart';

class CatalogRepository {
  List<WidgetDetails> getAllWidgets() {
    return [...blockList, ...pageList, ...componentList];
  }
}

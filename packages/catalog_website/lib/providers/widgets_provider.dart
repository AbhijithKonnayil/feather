import 'package:catalog_website/_generated/block.g.dart';
import 'package:catalog_website/_generated/component.g.dart';
import 'package:catalog_website/_generated/page.g.dart';
import 'package:catalog_website/providers/search_provider.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widgets_provider.g.dart';

class WidgetsNotifier extends Notifier<List<WidgetDetails>> {
  @override
  build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

@riverpod
List<WidgetDetails> filteredWidgetsNotifier(Ref ref) {
  final Map<WidgetScope, List<WidgetDetails>> _types = {
    WidgetScope.block: blockList,
    WidgetScope.component: componentList,
    WidgetScope.page: pageList,
  };
  final selectedSidebarItem = ref.watch(selectedSidebarItemProvider);
  final selectedScope = ref.watch(selectedScopeProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return _types[selectedScope]!
      .where(
        (element) =>
            element.categories.contains(selectedSidebarItem) ||
            element.types.contains(selectedSidebarItem) &&
                (element.name.toLowerCase().contains(query)),
      )
      .toList();
}

@riverpod
class SelectedScopeNotifier extends _$SelectedScopeNotifier {
  @override
  WidgetScope build() {
    return WidgetScope.page;
  }

  void changeScope(WidgetScope scope) {
    state = scope;
  }
}

@riverpod
class SelectedSidebarModeNotifier extends _$SelectedSidebarModeNotifier {
  @override
  Type build() {
    return WidgetType;
  }

  void changeType(Type type) {
    state = type;
  }
}

@riverpod
List<LabeledEnum> sidebarMenuItemsNotifier(ref) {
  final type = ref.watch(selectedSidebarModeProvider);
  if (type == WidgetType) {
    return ref.watch(typeProvider);
  } else if (type == WidgetCategory) {
    return ref.watch(categoryProvider);
  } else {
    return [];
  }
}

@riverpod
class TypeNotifier extends _$TypeNotifier {
  final Map<WidgetScope, List<WidgetType>> _types = {
    WidgetScope.block: BlockType.values,
    WidgetScope.component: ComponentType.values,
    WidgetScope.page: PageType.values,
  };
  @override
  List<WidgetType> build() {
    final scope = ref.watch(selectedScopeProvider);
    return _types[scope]!;
  }
}

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  final Map<WidgetScope, List<WidgetCategory>> _categories = {
    WidgetScope.block: BlockCategory.values,
    WidgetScope.component: ComponentCategory.values,
    WidgetScope.page: PageCategory.values,
  };
  @override
  List<WidgetCategory> build() {
    final scope = ref.watch(selectedScopeProvider);
    return _categories[scope]!;
  }
}

@riverpod
class SelectedSidebarItemNotifier extends _$SelectedSidebarItemNotifier {
  @override
  LabeledEnum build() {
    final type = ref.watch(sidebarMenuItemsProvider);
    return type.first;
  }

  void changeType(LabeledEnum type) {
    state = type;
  }
}

@riverpod
class SelectedWidgetNotifier extends _$SelectedWidgetNotifier {
  @override
  WidgetDetails? build() {
    return null;
  }

  void changeWidget(WidgetDetails widget) {
    state = widget;
  }

  void toggleWidget(WidgetDetails widget) {
    state = state == widget ? null : widget;
  }
}

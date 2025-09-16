import 'package:catalog_website/core/locator.dart';
import 'package:catalog_website/features/catalog/bloc/catalog_bloc.dart';
import 'package:catalog_website/widgets/sidebar/sidebar.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';

part 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  final controller = SidebarXController(selectedIndex: 0, extended: false);
  final CatalogBloc _catalogBloc = locator<CatalogBloc>();

  late String selectedHeader;

  SidebarCubit() : super(SidebarInitial()) {
    selectedHeader = _currentScopeMenu.keys.first;
    headerMenuClicked(selectedHeader);
  }

  final Map<WidgetScope, Map<String, List<LabeledEnum>>> _scopeMenuMap = {
    WidgetScope.page: {
      "Type": PageType.values,
      "Category": PageCategory.values,
    },
    WidgetScope.block: {
      "Type": BlockType.values,
      "Category": BlockCategory.values,
    },
    WidgetScope.component: {
      "Type": ComponentType.values,
      "Category": ComponentCategory.values,
    },
  };

  /// Current menu depending on selected scope
  Map<String, List<LabeledEnum>> get _currentScopeMenu =>
      _scopeMenuMap[_catalogBloc.selectedWidgetScope]!;

  /// Sidebar menu items
  List<SidebarItemAdapter> get menuItems => _currentScopeMenu[selectedHeader]!
      .map((e) => SidebarItemAdapter(value: e))
      .toList();

  /// Menu headers
  List<String> get _headerMenu => _currentScopeMenu.keys.toList();

  /// Menu header adapters
  List<HeaderAdapter> get menuHeader => _headerMenu
      .map(
        (label) =>
            HeaderAdapter(label: label, isSelected: label == selectedHeader),
      )
      .toList();

  /// Called when widget scope changes from bloc
  void handleWidgetScopeChanged(WidgetScope widgetScope) {
    selectedHeader = _currentScopeMenu.keys.first;
    _emitLoaded();
  }

  /// Called when user clicks on menu header
  void headerMenuClicked(String selectedLabel) {
    selectedHeader = selectedLabel;
    controller.selectIndex(0);

    _catalogBloc.add(
      CategoryGroupSelected(
        widgetCategoryOrType: menuItems[controller.selectedIndex].value,
      ),
    );

    _emitLoaded();
  }

  void _emitLoaded() {
    emit(SidebarLoaded(headerAdapter: menuHeader, menus: menuItems));
  }
}

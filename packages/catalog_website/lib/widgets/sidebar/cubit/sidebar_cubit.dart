import 'package:catalog_website/features/catalog/bloc/catalog_bloc.dart';
import 'package:catalog_website/widgets/sidebar/sidebar.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';

part 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  final controller = SidebarXController(selectedIndex: 0, extended: false);
  String selectedHeader = "Category";
  SidebarCubit() : super(SidebarInitial());
  Map<String, List<SidebarItemAdapter>> menuItems = {
    "Category": WidgetComponent.values
        .map((e) => SidebarItemAdapter(value: e))
        .toList(),
    "Widget Group": WidgetGroup.values
        .map((e) => SidebarItemAdapter(value: e))
        .toList(),
  };

  List<String> get menu => menuItems.keys.toList();

  headerMenuClicked(String selectedLabel, BuildContext context) {
    selectedHeader = selectedLabel;
    context.read<CatalogBloc>().add(
      CategoryGroupSelected(
        labeledEnum: menuItems[selectedLabel]![controller.selectedIndex].value,
      ),
    );
    final menuHeader = menu.asMap().entries.map((entry) {
      final label = entry.value;
      return HeaderAdapter(
        label: label,
        isSelected: label == selectedHeader, // true only for index 1
      );
    }).toList();
    emit(
      SidebarLoaded(
        headerAdapter: menuHeader,
        menus: menuItems[selectedHeader]!,
      ),
    );
  }
}

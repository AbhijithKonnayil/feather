import 'package:bloc/bloc.dart';
import 'package:catalog_website/widgets/sidebar/sidebar.dart';
import 'package:feather_core/feather_core.dart';
import 'package:meta/meta.dart';
import 'package:sidebarx/sidebarx.dart';

part 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  final controller = SidebarXController(selectedIndex: 0, extended: false);
  SidebarCubit() : super(SidebarInitial());
  Map<String, List<SidebarItemAdapter>> menuItems = {
    "Category": WidgetComponent.values
        .map((e) => SidebarItemAdapter(label: e.label))
        .toList(),
    "Widget Group": WidgetGroup.values
        .map((e) => SidebarItemAdapter(label: e.label))
        .toList(),
  };

  List<String> get menu => menuItems.keys.toList();

  headerMenuClicked(String selectedLabel) {
    final menuHeader = menu.asMap().entries.map((entry) {
      final label = entry.value;
      return HeaderAdapter(
        label: label,
        isSelected: label == selectedLabel, // true only for index 1
      );
    }).toList();
    emit(
      SidebarLoaded(
        headerAdapter: menuHeader,
        menus: menuItems[selectedLabel]!,
      ),
    );
  }
}

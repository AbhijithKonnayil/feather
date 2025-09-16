import 'package:catalog_website/features/catalog/bloc/catalog_bloc.dart';
import 'package:catalog_website/widgets/sidebar/cubit/sidebar_cubit.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';

class FeatherSidebar extends StatelessWidget {
  final List<WidgetDetails> items;
  final TextEditingController searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  FeatherSidebar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarCubit, SidebarState>(
      builder: (context, state) {
        if (state is SidebarLoaded) {
          return SidebarX(
            animationDuration: Duration(milliseconds: 250),
            controller: context.read<SidebarCubit>().controller,
            theme: collapseTheme(),
            extendedTheme: buildExtendedTheme(),
            headerBuilder: (context, extended) => buildHeader(
              extended: extended,
              headerMenu: state.headerAdapter,
              context: context,
            ),
            items: state.menus
                .map(
                  (e) => SidebarXItem(
                    onTap: () {
                      context.read<CatalogBloc>().add(
                        CategoryGroupSelected(widgetCategoryOrType: e.value),
                      );
                    },
                    label: e.label,
                    iconBuilder: (selected, hovered) {
                      if (context.read<SidebarCubit>().controller.extended) {
                        return SizedBox.shrink();
                      }
                      return SizedBox(
                        width: 30,
                        child: Text(
                          e.label,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white70,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        } else {
          return Container(color: Colors.white10, child: Text("dsf"));
        }
      },
    );
  }

  SidebarXTheme buildExtendedTheme() {
    return SidebarXTheme(
      width: 240,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF0D1B2A), // slightly lighter navy
      ),
    );
  }

  SidebarXTheme collapseTheme() {
    return SidebarXTheme(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1622), // deep navy background
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      selectedItemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00C9A7), // teal
            Color(0xFF0072FF), // blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      textStyle: TextStyle(
        color: Colors.white.withOpacity(0.75),
        fontWeight: FontWeight.w500,
      ),
      selectedTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      hoverColor: Colors.amber,
      hoverIconTheme: IconThemeData(color: Colors.blue.shade200),
      hoverTextStyle: TextStyle(color: Colors.blue.shade200),
      selectedIconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget buildHeader({
    required BuildContext context,
    required bool extended,
    required List<HeaderAdapter> headerMenu,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          ...headerMenu.map((e) => e.getMenuWidget(context, extended)),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00C9A7), Color(0xFF0072FF)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderAdapter {
  final String label;
  final bool isSelected;

  HeaderAdapter({required this.label, required this.isSelected});
  Widget getMenuWidget(BuildContext context, bool expanded) {
    return InkWell(
      onTap: () {
        if (!isSelected) context.read<SidebarCubit>().headerMenuClicked(label);
      },
      borderRadius: BorderRadius.circular(3),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        height: 45,
        alignment: Alignment.center,
        decoration: isSelected
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00C9A7), Color(0xFF0072FF)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            overflow: !expanded ? TextOverflow.ellipsis : null,
          ),
        ),
      ),
    );
  }
}

class SidebarItemAdapter {
  String get label => value.label;
  final LabeledEnum value;
  SidebarItemAdapter({required this.value});
  Widget iconBuilder() {
    return SizedBox.shrink();
  }
}

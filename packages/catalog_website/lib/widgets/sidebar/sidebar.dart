import 'package:catalog_website/features/catalog/bloc/catalog_bloc.dart';
import 'package:catalog_website/widgets/searchbox.dart' show FeatherSearchBox;
import 'package:catalog_website/widgets/sidebar/cubit/sidebar_cubit.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
          print(state.menus);
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
                        CategoryGroupSelected(labeledEnum: e.value),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/feather_logo.png',
                    //height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              if (extended) ...[
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    "Feather",
                    style: GoogleFonts.alexBrush(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                    overflow: TextOverflow
                        .ellipsis, // optional: show "..." if too long
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C9A7), Color(0xFF0072FF)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 60,
            child: extended
                ? Row(
                    children: [
                      Expanded(
                        child: FeatherSearchBox(
                          controller: searchController,
                          focusNode: searchFocusNode,
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    icon: const Icon(Icons.search, color: Colors.grey),
                    onPressed: () {
                      context.read<SidebarCubit>().controller.setExtended(true);
                      (searchFocusNode);
                    },
                  ),
          ),
          ...headerMenu.map((e) => e.getMenuWidget(context, extended)),
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
        context.read<SidebarCubit>().headerMenuClicked(label, context);
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

import 'dart:core';

import 'package:catalog_website/features/catalog/bloc/catalog_bloc.dart';
import 'package:catalog_website/widgets/sidebar/cubit/sidebar_cubit.dart';
import 'package:catalog_website/widgets/sidebar/sidebar.dart';
import 'package:feather_core/feather_core.dart' show WidgetDetails;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CatalogBloc()),
        BlocProvider(
          create: (context) =>
              SidebarCubit()..headerMenuClicked("Category", context),
        ),
      ],
      child: _CatalogPageBody(),
    );
  }
}

class _CatalogPageBody extends StatelessWidget {
  _CatalogPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          buildSidebar(),
          Flexible(child: buildCatalog()),
        ],
      ),
    );
  }

  GridView buildGridView(List<WidgetDetails> filteredWidgets) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 28,
        crossAxisSpacing: 28,
        childAspectRatio: 1.2,
      ),
      itemCount: filteredWidgets.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          shadowColor: Colors.deepPurple.withOpacity(0.10),
          child: Container(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(child: filteredWidgets[index].example()),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        filteredWidgets[index].installCommand,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        tooltip: 'Copy',
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: filteredWidgets[index].installCommand,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Copied "${filteredWidgets[index].installCommand}"',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSidebar() {
    return FeatherSidebar(items: []);
  }

  SizedBox buildAppbar() {
    return SizedBox.shrink();
  }

  Widget buildCatalog() {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        if (state is CatalogWidgetsLoadedState) {
          if (state.widgets.isEmpty) {
            return Center(
              child: SizedBox.square(
                dimension: 500,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset("assets/images/no_items.png"),
                    Text(
                      "No Widgets",
                      style: GoogleFonts.alexBrush(
                        color: Colors.red.shade300,
                        fontSize: 45,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return buildGridView(state.widgets);
        }
        return Container(color: Colors.amber);
      },
    );
  }
}

import 'dart:core';

import 'package:catalog_website/core/locator.dart';
import 'package:catalog_website/features/catalog/bloc/catalog_bloc.dart';
import 'package:catalog_website/widgets/gradient_button.dart';
import 'package:catalog_website/widgets/searchbox.dart';
import 'package:catalog_website/widgets/sidebar/cubit/sidebar_cubit.dart';
import 'package:catalog_website/widgets/sidebar/sidebar.dart';
import 'package:feather_core/feather_core.dart' show WidgetDetails, WidgetScope;
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
        BlocProvider.value(value: locator<CatalogBloc>()),
        BlocProvider.value(
          value: locator<SidebarCubit>(),
          //..headerMenuClicked("Category", context),
        ),
      ],
      child: _CatalogPageBody(),
    );
  }
}

class _CatalogPageBody extends StatelessWidget {
  const _CatalogPageBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 75),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/feather_logo.png',
                //height: 50,
                fit: BoxFit.contain,
              ),

              SizedBox(width: 10),
              Text(
                "Feather",
                style: GoogleFonts.alexBrush(color: Colors.blue, fontSize: 50),
                overflow:
                    TextOverflow.ellipsis, // optional: show "..." if too long
              ),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<CatalogBloc, CatalogState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 5,
                            children: [
                              ...WidgetScope.values.map((e) {
                                return SizedBox(
                                  width: 100,
                                  height: 45,
                                  child: GradientButton(
                                    label: e.label,
                                    isSelected:
                                        context
                                            .read<CatalogBloc>()
                                            .selectedWidgetScope ==
                                        e,
                                    onTap: () =>
                                        context.read<CatalogBloc>().add(
                                          WidgetScopeChangedEvent(
                                            widgetScope: e,
                                          ),
                                        ),
                                  ),
                                );
                              }),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: FeatherSearchBox(
                        controller: TextEditingController(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
        final widgetDetail = filteredWidgets[index];

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          shadowColor: Colors.deepPurple.withOpacity(0.10),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                // Flexible widget area
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: widgetDetail.example(),
                  ),
                ),

                const SizedBox(height: 8),

                // Bottom info row
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widgetDetail.installCommand,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        tooltip: 'Copy',
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: widgetDetail.installCommand),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Copied "${widgetDetail.installCommand}"',
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
        return SizedBox.shrink();
      },
    );
  }
}

import 'dart:async';

import 'package:catalog_website/_generated/blockList.g%20.dart';
import 'package:catalog_website/_generated/componentList.g.dart';
import 'package:catalog_website/_generated/pageList.g%20.dart';
import 'package:catalog_website/core/locator.dart';
import 'package:catalog_website/widgets/sidebar/cubit/sidebar_cubit.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<CategoryGroupSelected>(onCategoryGroupSelected);
    on<WidgetScopeChangedEvent>(handleWidgetScopeChange);
  }

  WidgetScope selectedWidgetScope = WidgetScope.component;

  final Map<WidgetScope, List<WidgetDetails>> compScopeMap = {
    WidgetScope.component: componentList,
    WidgetScope.block: blockList,
    WidgetScope.page: pageList,
  };

  List<WidgetDetails> getItems() => compScopeMap[selectedWidgetScope]!;

  List<WidgetDetails> getList([LabeledEnum? filter]) => getItems()
      .where(
        (e) =>
            filter == null ||
            e.types.contains(filter) ||
            e.categories.contains(filter),
      )
      .toList();

  FutureOr<void> onCategoryGroupSelected(
    CategoryGroupSelected event,
    Emitter<CatalogState> emit,
  ) {
    final list = getList(event.widgetCategoryOrType);
    emit(
      CatalogWidgetsLoadedState(
        widgets: list,
        selectedWidgetScope: event.widgetScope ?? selectedWidgetScope,
      ),
    );
  }

  FutureOr<void> handleWidgetScopeChange(
    WidgetScopeChangedEvent event,
    Emitter<CatalogState> emit,
  ) {
    selectedWidgetScope = event.widgetScope;

    emit(
      CatalogWidgetsLoadedState(
        widgets: getItems(),
        selectedWidgetScope: selectedWidgetScope,
      ),
    );

    // 🔒 fire-and-forget to avoid sync recursion
    Future.microtask(() {
      locator<SidebarCubit>().handleWidgetScopeChanged(selectedWidgetScope);
    });
  }
}

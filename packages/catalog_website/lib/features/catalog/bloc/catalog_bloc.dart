import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catalog_website/_generated/widget_list.g.dart';
import 'package:feather_core/feather_core.dart';
import 'package:meta/meta.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<CategoryGroupSelected>(onCategoryGroupSelected);
  }

  FutureOr<void> onCategoryGroupSelected(
    CategoryGroupSelected event,
    Emitter<CatalogState> emit,
  ) {
    if (event.labeledEnum is WidgetComponent) {
      final list = widgetList.where((e) {
        return e.widgetCategories.contains(event.labeledEnum);
      }).toList();
      emit(CatalogWidgetsLoadedState(widgets: list));
    } else {
      final list = widgetList.where((e) => true).toList();
      emit(CatalogWidgetsLoadedState(widgets: list));
    }
  }
}

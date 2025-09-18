part of 'catalog_bloc.dart';

@immutable
sealed class CatalogEvent {}

final class CategoryGroupSelected extends CatalogEvent {
  final LabeledEnum? widgetCategoryOrType;
  final WidgetScope? widgetScope;

  CategoryGroupSelected({this.widgetCategoryOrType, this.widgetScope});
}

final class WidgetScopeChangedEvent extends CatalogEvent {
  final WidgetScope widgetScope;

  WidgetScopeChangedEvent({required this.widgetScope});
}

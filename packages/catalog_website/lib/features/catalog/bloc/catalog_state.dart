part of 'catalog_bloc.dart';

@immutable
sealed class CatalogState {}

final class CatalogInitial extends CatalogState {}

final class CatalogWidgetsLoadedState extends CatalogState {
  final List<WidgetDetails> widgets;
  final WidgetScope selectedWidgetScope;
  CatalogWidgetsLoadedState({
    required this.widgets,
    required this.selectedWidgetScope,
  });
}

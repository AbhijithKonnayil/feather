part of 'catalog_bloc.dart';

@immutable
sealed class CatalogEvent {}

final class CategoryGroupSelected extends CatalogEvent {
  LabeledEnum labeledEnum;

  CategoryGroupSelected({required this.labeledEnum});
}

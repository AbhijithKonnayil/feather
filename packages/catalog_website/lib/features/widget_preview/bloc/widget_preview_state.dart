part of 'widget_preview_bloc.dart';

@immutable
sealed class WidgetPreviewState {}

final class WidgetPreviewInitial extends WidgetPreviewState {}

final class WidgetPreviewLoadedState extends WidgetPreviewState {
  final WidgetDetails widgetDetails;
  WidgetPreviewLoadedState({required this.widgetDetails});
}

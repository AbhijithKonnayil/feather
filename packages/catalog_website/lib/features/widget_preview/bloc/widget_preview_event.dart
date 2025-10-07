part of 'widget_preview_bloc.dart';

@immutable
sealed class WidgetPreviewEvent {}

final class WidgetPreviewLoadEvent extends WidgetPreviewEvent {
  final WidgetDetails widgetDetails;
  WidgetPreviewLoadEvent({required this.widgetDetails});
}

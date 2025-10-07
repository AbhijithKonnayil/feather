import 'package:bloc/bloc.dart';
import 'package:feather_core/feather_core.dart';
import 'package:meta/meta.dart';

part 'widget_preview_event.dart';
part 'widget_preview_state.dart';

class WidgetPreviewBloc extends Bloc<WidgetPreviewEvent, WidgetPreviewState> {
  WidgetPreviewBloc() : super(WidgetPreviewInitial()) {
    on<WidgetPreviewLoadEvent>((event, emit) {
      emit(WidgetPreviewLoadedState(widgetDetails: event.widgetDetails));
    });
  }
}

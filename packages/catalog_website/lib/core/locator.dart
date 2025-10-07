import 'package:catalog_website/features/catalog/bloc/catalog_bloc.dart';
import 'package:catalog_website/features/widget_preview/bloc/widget_preview_bloc.dart';
import 'package:catalog_website/widgets/sidebar/cubit/sidebar_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register blocs
  locator.registerLazySingleton<CatalogBloc>(() => CatalogBloc());
  locator.registerLazySingleton<SidebarCubit>(() => SidebarCubit());
  locator.registerLazySingleton<WidgetPreviewBloc>(() => WidgetPreviewBloc());
}

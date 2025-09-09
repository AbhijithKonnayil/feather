part of 'sidebar_cubit.dart';

@immutable
sealed class SidebarState {}

final class SidebarInitial extends SidebarState {}

final class SidebarLoaded extends SidebarState {
  final List<HeaderAdapter> headerAdapter;
  final List<SidebarItemAdapter> menus;
  SidebarLoaded({required this.headerAdapter, required this.menus});
}

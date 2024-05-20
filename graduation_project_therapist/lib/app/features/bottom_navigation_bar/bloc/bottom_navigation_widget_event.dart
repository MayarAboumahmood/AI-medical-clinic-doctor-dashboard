part of 'bottom_navigation_widget_bloc.dart';

final class BottomNavigationWidgetEvent extends Equatable {
  const BottomNavigationWidgetEvent();

  @override
  List<Object> get props => [];
}
final class ChangeCurrentPage extends BottomNavigationWidgetEvent {
  final int nextIndex;

  const ChangeCurrentPage({required this.nextIndex});

  @override
  List<Object> get props => [nextIndex];
}




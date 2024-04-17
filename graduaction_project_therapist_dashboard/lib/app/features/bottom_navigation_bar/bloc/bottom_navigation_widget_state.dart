part of 'bottom_navigation_widget_bloc.dart';

sealed class BottomNavigationWidgetState extends Equatable {
  const BottomNavigationWidgetState();
  
  @override
  List<Object> get props => [];
}

final class BottomNavigationWidgetInitial extends BottomNavigationWidgetState {}


final class PageChangedIndex extends BottomNavigationWidgetState  {
  final int currentPage;
  const PageChangedIndex({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

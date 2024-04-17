part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent extends Equatable {}

class LoadHomePageDataEvent extends HomePageEvent {
  LoadHomePageDataEvent();
  @override
  List<Object?> get props => [];
}

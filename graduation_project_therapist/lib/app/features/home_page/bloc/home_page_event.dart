part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent extends Equatable {}

class LoadHomePageDataEvent extends HomePageEvent {
  LoadHomePageDataEvent();
  @override
  List<Object?> get props => [];
}

class GetUserInfoEvent extends HomePageEvent {
  final bool shouldLoadTheUserInfo;
  GetUserInfoEvent({this.shouldLoadTheUserInfo = false});
  @override
  List<Object?> get props => [];
}

class GetUserStatusEvent extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

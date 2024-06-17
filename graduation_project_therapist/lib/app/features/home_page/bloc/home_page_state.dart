part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState extends Equatable {}

final class HomePageInitial extends HomePageState {
  @override
  List<Object?> get props => [];
}

final class FetchDataFauilerState extends HomePageState {
  final String errorMessage;
  FetchDataFauilerState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
final class GetUserStatesuccessfulyState extends HomePageState {

  GetUserStatesuccessfulyState();
  @override
  List<Object?> get props => [];
}

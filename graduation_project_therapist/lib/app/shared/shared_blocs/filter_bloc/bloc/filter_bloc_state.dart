part of 'filter_bloc_bloc.dart';

sealed class FilterBlocState extends Equatable {
  const FilterBlocState();
  
  @override
  List<Object> get props => [];
}

final class FilterBlocInitial extends FilterBlocState {}
final class FetchDataFauilerState extends FilterBlocState {
  final StatusRequest statusRequest;

  const FetchDataFauilerState({required this.statusRequest});

  @override
  List<Object> get props => [statusRequest];
}


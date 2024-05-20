part of 'filter_bloc_bloc.dart';

sealed class FilterBlocEvent extends Equatable {
  const FilterBlocEvent();

  @override
  List<Object> get props => [];
}
final class GetFilterCuisineEvent extends FilterBlocEvent {
  const GetFilterCuisineEvent();

  @override
  List<Object> get props => [];
}

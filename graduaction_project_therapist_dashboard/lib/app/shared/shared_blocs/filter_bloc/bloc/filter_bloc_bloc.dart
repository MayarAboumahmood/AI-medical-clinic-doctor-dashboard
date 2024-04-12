import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';

part 'filter_bloc_event.dart';
part 'filter_bloc_state.dart';

class FilterBlocBloc extends Bloc<FilterBlocEvent, FilterBlocState> {
  // final FetchAllCuisineUseCase fetchAllCuisineUseCase;

  FilterBlocBloc() : super(FilterBlocInitial()) {
    on<FilterBlocEvent>((event, emit) {});
  }
}

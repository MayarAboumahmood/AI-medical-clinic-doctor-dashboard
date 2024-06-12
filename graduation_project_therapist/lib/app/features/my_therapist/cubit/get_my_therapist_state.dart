import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';

sealed class GetMyTherapistState extends Equatable {}

final class GetMyTherapistInitial extends GetMyTherapistState {
  @override
  List<Object?> get props => [];
}

final class MyTherapistLoadingState extends GetMyTherapistState {
  @override
  List<Object?> get props => [];
}

final class MyTherapistLoadedState extends GetMyTherapistState {
  final List<GetTherapistModel> getTherapistModels;
  MyTherapistLoadedState({required this.getTherapistModels});
  @override
  List<Object?> get props => [getTherapistModels];
}

final class RemoveTherapistLoadingState extends GetMyTherapistState {
  @override
  List<Object?> get props => [];
}

final class TherapistRemovedSuccessfullyState extends GetMyTherapistState {
  @override
  List<Object?> get props => [];
}

final class MyTherapistErrorState extends GetMyTherapistState {
  final String errorMessage;
  MyTherapistErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class SearchOnMyTherapistState extends GetMyTherapistState {
  final List<GetTherapistModel> searchedTherapistModels;
  final DateTime dateTime;
  SearchOnMyTherapistState(
      {required this.searchedTherapistModels, required this.dateTime});
  @override
  List<Object?> get props => [searchedTherapistModels, dateTime];
}

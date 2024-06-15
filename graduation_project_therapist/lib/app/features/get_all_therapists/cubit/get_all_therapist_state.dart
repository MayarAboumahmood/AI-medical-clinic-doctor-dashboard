import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';

sealed class GetAllTherapistState extends Equatable {}

final class GetAllTherapistInitial extends GetAllTherapistState {
  @override
  List<Object?> get props => [];
}

final class AllTherapistLoadingState extends GetAllTherapistState {
  @override
  List<Object?> get props => [];
}

final class AllTherapistLoadedState extends GetAllTherapistState {
  final List<GetTherapistModel> getTherapistModels;
  AllTherapistLoadedState({required this.getTherapistModels});
  @override
  List<Object?> get props => [getTherapistModels];
}

final class AssignTherapistLoadingState extends GetAllTherapistState {
  @override
  List<Object?> get props => [];
}

final class AssignTherapistSuccessfullyState extends GetAllTherapistState {
  @override
  List<Object?> get props => [];
}

final class AllTherapistErrorState extends GetAllTherapistState {
  final String errorMessage;
  AllTherapistErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class SearchOnAllTherapistState extends GetAllTherapistState {
  final List<GetTherapistModel> searchedTherapistModels;
  final DateTime dateTime;
  SearchOnAllTherapistState(
      {required this.searchedTherapistModels, required this.dateTime});
  @override
  List<Object?> get props => [searchedTherapistModels, dateTime];
}


final class GetMyTherapistInitial extends GetAllTherapistState {
  @override
  List<Object?> get props => [];
}

final class MyTherapistLoadingState extends GetAllTherapistState {
  @override
  List<Object?> get props => [];
}

final class MyTherapistLoadedState extends GetAllTherapistState {
  final List<GetTherapistModel> getTherapistModels;
  MyTherapistLoadedState({required this.getTherapistModels});
  @override
  List<Object?> get props => [getTherapistModels];
}

final class RemoveTherapistLoadingState extends GetAllTherapistState {
  @override
  List<Object?> get props => [];
}

final class TherapistRemovedSuccessfullyState extends GetAllTherapistState {
  final DateTime dateTime;
  TherapistRemovedSuccessfullyState({required this.dateTime});
  @override
  List<Object?> get props => [dateTime];
}

final class MyTherapistErrorState extends GetAllTherapistState {
  final String errorMessage;
  MyTherapistErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class SearchOnMyTherapistState extends GetAllTherapistState {
  final List<GetTherapistModel> searchedTherapistModels;
  final DateTime dateTime;
  SearchOnMyTherapistState(
      {required this.searchedTherapistModels, required this.dateTime});
  @override
  List<Object?> get props => [searchedTherapistModels, dateTime];
}


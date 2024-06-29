import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/models/get_patients_model.dart';

sealed class GetPatientsState extends Equatable {}

final class GetPatientsInitial extends GetPatientsState {
  @override
  List<Object?> get props => [];
}

final class PatientsLoadingState extends GetPatientsState {
  @override
  List<Object?> get props => [];
}

final class PatientsLoadedState extends GetPatientsState {
  final List<GetPatientsModel> getPatientsModel;
  PatientsLoadedState({required this.getPatientsModel});
  @override
  List<Object?> get props => [getPatientsModel];
}

final class PatientsErrorState extends GetPatientsState {
  final String errorMessage;
  PatientsErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class SearchOnPatientsState extends GetPatientsState {
  final List<GetPatientsModel> searchedPatientsModels;
  final DateTime dateTime;
  SearchOnPatientsState(
      {required this.searchedPatientsModels, required this.dateTime});
  @override
  List<Object?> get props => [searchedPatientsModels, dateTime];
}

final class GetMyPatientsInitial extends GetPatientsState {
  @override
  List<Object?> get props => [];
}

final class MyPatientsLoadingState extends GetPatientsState {
  @override
  List<Object?> get props => [];
}

final class MyPatientsLoadedState extends GetPatientsState {
  final List<GetPatientsModel> getPatientsModel;
  MyPatientsLoadedState({required this.getPatientsModel});
  @override
  List<Object?> get props => [getPatientsModel];
}

final class RemovePatientsLoadingState extends GetPatientsState {
  @override
  List<Object?> get props => [];
}

final class PatientsRemovedSuccessfullyState extends GetPatientsState {
  final DateTime dateTime;
  PatientsRemovedSuccessfullyState({required this.dateTime});
  @override
  List<Object?> get props => [dateTime];
}

final class MyPatientsErrorState extends GetPatientsState {
  final String errorMessage;
  MyPatientsErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class SearchOnMyPatientsState extends GetPatientsState {
  final List<GetPatientsModel> searchedPatientsModels;
  final DateTime dateTime;
  SearchOnMyPatientsState(
      {required this.searchedPatientsModels, required this.dateTime});
  @override
  List<Object?> get props => [searchedPatientsModels, dateTime];
}

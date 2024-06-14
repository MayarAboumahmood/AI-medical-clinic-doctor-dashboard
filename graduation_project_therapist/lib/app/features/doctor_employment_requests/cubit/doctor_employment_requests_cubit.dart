import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/data_source/models/doctor_employment_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/repo/doctor_employment_requests_repo.dart';
import 'package:meta/meta.dart';

part 'doctor_employment_requests_state.dart';

class DoctorEmploymentRequestsCubit
    extends Cubit<DoctorEmploymentRequestsState> {
  DoctorEmploymentRequestsCubit(
      {required this.doctoreEmploymentRequestRepositoryImp})
      : super(DoctorEmploymentRequestsInitial());
  final DoctoreEmploymentRequestRepositoryImp
      doctoreEmploymentRequestRepositoryImp;
  int? requestID;
  List<DoctorEmploymentRequestModel> doctorEmploymentRequests = [];

  void getAllDoctorEmploymentRequests() async {
    emit(DoctorEmploymentRequestsLoadingState());
    final getData = await doctoreEmploymentRequestRepositoryImp
        .getAllDoctorEmploymentRequests();
    getData.fold(
        (errorMessage) => emit(
            DoctorEmploymentRequestsErrorState(errorMessage: errorMessage)),
        (data) {
      doctorEmploymentRequests = data;
      emit(AllRequestLoadedSuccessfullyState());
    });
  }

  void approveDoctorRequest(int id) async {
    requestID = id;
    emit(ApproveDoctorRequestsLoadingState());
    final getData = await doctoreEmploymentRequestRepositoryImp
        .approveDoctorEmploymentRequest(id, true);
    getData.fold(
        (errorMessage) => emit(
            DoctorEmploymentRequestsErrorState(errorMessage: errorMessage)),
        (data) {
      emit(DoctorEmploymentApproveRequestsState());
    });
  }

  void declineDoctorRequest(int id) async {
    requestID = id;
    emit(ApproveDoctorRequestsLoadingState());
    final getData = await doctoreEmploymentRequestRepositoryImp
        .approveDoctorEmploymentRequest(id, false);
    getData.fold(
        (errorMessage) => emit(
            DoctorEmploymentRequestsErrorState(errorMessage: errorMessage)),
        (data) {
      emit(DoctorEmploymentDeclinedRequestsState());
    });
  }
}

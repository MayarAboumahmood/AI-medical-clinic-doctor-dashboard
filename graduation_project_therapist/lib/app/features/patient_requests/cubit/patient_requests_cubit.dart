import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/repo/patient_requests_repository.dart';
import 'package:meta/meta.dart';

part 'patient_requests_state.dart';

class PatientRequestsCubit extends Cubit<PatientRequestsState> {
  PatientRequestsCubit({required this.patientRequestsRepositoryImp})
      : super(PatientRequestsInitial());
  final PatientRequestsRepositoryImp patientRequestsRepositoryImp;
  String? selectedTime;
  String? selectedDay;

  List<PatientRequestModel> cachedUserRequests = [];
  void setSelectedTime(String newSelectedTime) {
    selectedTime = newSelectedTime;
  }

  void setSelectedDay(String newSelectedDay) {
    selectedDay = newSelectedDay;
  }

  void acceptPatientRequest(int requestID) async {
    emit(PatientRequestAcceptLoadingState());
    final getData = await patientRequestsRepositoryImp.acceptPatientRequest(
        requestID, selectedDay ?? '', selectedTime ?? '');
    getData.fold(
        (errorMessage) =>
            emit(PatientRequestErrorState(errorMessage: errorMessage)), (data) {
      cachedUserRequests.removeWhere((item) => item.id == requestID);
      emit(PatientRequestApprovedSuccessfullyState());
    });
  }

  void rejectPatientRequest(int requestID) async {
    emit(PatientRequestRejectLoadingState());
    final getData =
        await patientRequestsRepositoryImp.rejectPatientRequest(requestID);
    getData.fold(
        (errorMessage) =>
            emit(PatientRequestErrorState(errorMessage: errorMessage)), (data) {
      cachedUserRequests.removeWhere((item) => item.id == requestID);
      emit(PatientRequestRejectedSuccessfullyState(dateTime: DateTime.now()));
    });
  }

  void getPatientRequests() async {
    emit(PatientRequestLoadingState());
    final getData = await patientRequestsRepositoryImp.getPatientRequests();
    getData.fold(
        (errorMessage) =>
            emit(PatientRequestErrorState(errorMessage: errorMessage)), (data) {
      cachedUserRequests = data;
      emit(PatientRequestDataLoadedState(patientRequestModels: data));
    });
  }
}

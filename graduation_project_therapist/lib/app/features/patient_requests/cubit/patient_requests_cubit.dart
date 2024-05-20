import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:meta/meta.dart';

part 'patient_requests_state.dart';

class PatientRequestsCubit extends Cubit<PatientRequestsState> {
  PatientRequestsCubit() : super(PatientRequestsInitial());
  String? selectedTime;
  String? selectedDay;

  List<PatientRequestModel> cachedUserRequests = [
    PatientRequestModel(
      id: 1,
      userName: "John Doe",
      userInfo: "Lorem consectetur adipiscing elit.",
      userImage: "https://via.placeholder.com/150",
    ),
    PatientRequestModel(
      id: 2,
      userName: "Jane Smith",
      userInfo:
          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      userImage: "https://via.placeholder.com/150",
    ),
    PatientRequestModel(
      id: 3,
      userName: "Alice Johnson",
      userInfo:
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      userImage: "https://via.placeholder.com/150",
    ),
  ];
  void setSelectedTime(String newSelectedTime) {
    selectedTime = newSelectedTime;
  }

  void setSelectedDay(String newSelectedDay) {
    selectedDay = newSelectedDay;
  }

  void approveOnPatientRequest(int requestID) {
    // if (response.statusCode == 200) {
    cachedUserRequests.removeWhere((item) => item.id == requestID);
    // }
    //TODO send the date to the backend.
    emit(PatientRequestApprovedSuccessfullyState());
  }

  void rejectOnPatientRequest(int requestID) {
    // if (response.statusCode == 200) {
    cachedUserRequests.removeWhere((item) => item.id == requestID);
    // }
    //TODO send the date to the backend.
    emit(PatientRequestRejectedSuccessfullyState());
  }

  void getPatientRequests() {
    emit(PatientRequestLoadingState());

    Future.delayed(const Duration(seconds: 1), () {
      emit(PatientRequestDataLoadedState(
          patientRequestModels: cachedUserRequests));
    });
  }
}

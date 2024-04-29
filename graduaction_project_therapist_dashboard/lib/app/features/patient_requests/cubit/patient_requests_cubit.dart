import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:meta/meta.dart';

part 'patient_requests_state.dart';

class PatientRequestsCubit extends Cubit<PatientRequestsState> {
  PatientRequestsCubit() : super(PatientRequestsInitial());
  List<PatientRequestModel> fakeUserRequests = [
    PatientRequestModel(
      userName: "John Doe",
      userInfo: "Lorem consectetur adipiscing elit.",
      userImage: "https://via.placeholder.com/150",
    ),
    PatientRequestModel(
      userName: "Jane Smith",
      userInfo:
          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      userImage: "https://via.placeholder.com/150",
    ),
    PatientRequestModel(
      userName: "Alice Johnson",
      userInfo:
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      userImage: "https://via.placeholder.com/150",
    ),
  ];

  void getPatientRequests() {
    emit(PatientRequestLoadingState());

    Future.delayed(const Duration(seconds: 1), () {
      emit(PatientRequestDataLoadedState(
          patientRequestModels: fakeUserRequests));
    });
  }
}

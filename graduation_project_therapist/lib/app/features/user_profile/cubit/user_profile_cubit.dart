import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/patient_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/repo/patient_profile_repo.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({required this.patientsProfileRepositoryImp})
      : super(UserProfileInitial());
  final PatientsProfileRepositoryImp patientsProfileRepositoryImp;
  int cachedPatientID = -1;
  void getUserProfile(int patientID) async {
    cachedPatientID = patientID;
    emit(UserProfileLoadingState());
    final getData =
        await patientsProfileRepositoryImp.getPatientsProfile(patientID);
    getData.fold(
        (errorMessage) =>
            emit(UserProfileErrorState(errorMessage: errorMessage)),
        (data) => emit(UserProfileGetData(patientProfileModel: data)));
  }

  void assignPatientToTherapist(int therapistID) async {
    emit(AssignPatientToTherapistLoadingState());
    final getData = await patientsProfileRepositoryImp.assignPatientToTherapist(
        cachedPatientID, therapistID);
    getData.fold(
        (errorMessage) => emit(
            AssignPatientToTherapistErrorState(errorMessage: errorMessage)),
        (data) => emit(PatientAssignedToTherapistState()));
  }
}

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
    print('slfdjksldkfjsdklfj$cachedPatientID kjsldfslkdjfslkdjf $therapistID');
    final getData = await patientsProfileRepositoryImp.assignPatientToTherapist(
        cachedPatientID, therapistID);
    getData.fold(
        (errorMessage) => emit(
            AssignPatientToTherapistErrorState(errorMessage: errorMessage)),
        (data) => emit(PatientAssignedToTherapistState(isRequest: false)));
  }

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String time = DateFormat("h:mm a").format(DateTime.now());
  String description = '';
  void therapistRequestToPateint(int userId) async {
    emit(AssignPatientToTherapistLoadingState());

    final getData = await patientsProfileRepositoryImp
        .therapistRequestToPateint(date, time, userId, description);
    getData.fold(
        (errorMessage) => emit(
            AssignPatientToTherapistErrorState(errorMessage: errorMessage)),
        (data) => emit(PatientAssignedToTherapistState(isRequest: true)));
  }

  void getPatientsBotScore(int userId) async {
    // emit(GetPatientBotScoreLoadingState());
    final getData =
        await patientsProfileRepositoryImp.getPatientsBotScore(userId);
    getData.fold(
        (errorMessage) =>
            emit(GetPatientBotScoreErrorState(errorMessage: errorMessage)),
        (data) => emit(GetingPatientBotScoreDoneState(
            botScore: data.data.isNotEmpty
                ? data.data.first.score
                : "The patient hasn't taken the test yet.".tr())));
  }
}

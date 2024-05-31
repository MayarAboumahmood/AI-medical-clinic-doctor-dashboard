import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/user_profile_model.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  PatientProfileModel? patientProfileModel;
  void getUserProfile(int requestID) {
    emit(UserProfileLoadingState());
    patientProfileModel = PatientProfileModel.generateFakeUserProfile();
    Future.delayed(const Duration(seconds: 1), () {
      emit(UserProfileGetData(patientProfileModel: patientProfileModel!));
    });
  }
}

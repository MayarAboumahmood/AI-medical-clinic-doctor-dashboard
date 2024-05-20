import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';

abstract class EditProfileRepository {
  Future<Either<StatusRequest, Unit>> editProfile(
      EditProfileModel editProfileEntity);
  Future<Either<StatusRequest, Unit>> resetPassword(
      String old, String newPassword, String recheckNewPassword);
  Future<Either<StatusRequest, int>> deleteAccount();
}

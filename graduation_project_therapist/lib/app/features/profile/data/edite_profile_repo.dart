import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';

abstract class EditProfileRepository {
  Future<Either<String, String>> editProfile(
      EditProfileModel editProfileEntity);
  Future<Either<String , String>> resetPassword(
      String old, String newPassword);
  Future<Either<String,String>> deleteAccount();
}

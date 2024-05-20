import 'package:dartz/dartz.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/data_source/profile_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/edite_profile_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final ProfileDataSource profileDataSource;

  EditProfileRepositoryImpl(this.profileDataSource);
  @override
  Future<Either<StatusRequest, Unit>> editProfile(
      EditProfileModel editProfileModel) async {
    try {
      final int response =
          await profileDataSource.editProfile(editProfileModel);
      if (response == 200) {
        return const Right(unit);
      } else if (response == 403) {
        return const Left(StatusRequest.validationError);
      } else {
        const Left(StatusRequest.serverError);
      }
    } catch (e) {
      return const Left(StatusRequest.serverError);
    }
    return const Left(StatusRequest.serverError);
  }

  @override
  Future<Either<StatusRequest, Unit>> resetPassword(
      String old, String newPassword, String recheckNewPassword) async {
    try {
      final int response = await profileDataSource.resetPassword(
          old, newPassword, recheckNewPassword);
      if (response == 200) {
        return const Right(unit);
      } else if (response == 401) {
        return const Left(StatusRequest.oldPasswordIsWrong);
      } else if (response == 422) {
        return const Left(StatusRequest.validationError);
      } else {
        const Left(StatusRequest.serverError);
      }
    } catch (e) {
      return const Left(StatusRequest.serverError);
    }
    return const Left(StatusRequest.serverError);
  }

  @override
  Future<Either<StatusRequest, int>> deleteAccount() async {
    try {
      final int response = await profileDataSource.deleteAccount();
      if (response == 200) {
        return const Right(200);
      } else {
        return left(getStatusFromCode(response));
      }
    } catch (e) {
      return const Left(StatusRequest.serverError);
    }
  }
}

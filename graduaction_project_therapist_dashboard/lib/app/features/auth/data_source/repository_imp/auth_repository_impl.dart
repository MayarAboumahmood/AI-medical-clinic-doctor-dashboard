import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/data_source/remot_data_source.dart';

class AuthRepositoryImpl {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  /*
  Future<Either<StatusRequest, Unit>> register(
      RegisterEntity registerEntity) async {
    final RegisterModel registerModel = RegisterModel(
        firstName: registerEntity.firstName,
        lastName: registerEntity.lastName,
        phoneNumber: registerEntity.phoneNumber,
        email: registerEntity.email);
    try {
      final Response response =
          await authRemoteDataSource.register(registerModel);
      print('the register bloc ${response.statusCode}');
      final responseStatusCode = getStatusFromCode(response.statusCode);
      if (response.statusCode == 200) {
        return const Right(unit);
      } else if (response.statusCode == 205) {
        return const Left(StatusRequest.phoneNumberNotVerified);
      } else if (response.statusCode == 401) {
        return const Left(
          StatusRequest.takenPhoneNumber,
        );
      } else {
        return Left(responseStatusCode);
      }
      // } else if (response.statusCode == 205) {
      //   return const Left(StatusRequest.phoneNumberNotVerified);
      // } else if (response.statusCode == 403) {
      //   return const Left(StatusRequest.takenPhoneNumber);
      // } else if (response.statusCode == 401 || response.statusCode == 201) {
      //   return const Left(StatusRequest.authErorr);
      // } else {
      //   const Left(StatusRequest.serverError);
      // }
    } catch (e) {
      return const Left(StatusRequest.serverError);
    }
    // return const Left(StatusRequest.serverError);
  }
*/
}

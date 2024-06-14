import 'package:flutter/foundation.dart';
import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/formate_name.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/gender_for_backend_functions.dart';

import 'package:http/http.dart' as http;
import 'package:graduation_project_therapist_dashboard/app/core/service/shared_preferences.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';
import 'package:http/http.dart';

abstract class ProfileDataSource {
  Future<Response> editProfile(EditProfileModel editProfileModel);
  Future<Response> deleteAccount();
  Future<Response> resetPassword(
    String old,
    String newPassword,
  );
}

class ProfileDataSourceImpl implements ProfileDataSource {
  http.Client client;
  ProfileDataSourceImpl({
    required this.client,
  });

  @override
  Future<Response> editProfile(EditProfileModel editProfileModel) async {
    String token = await sl<PrefService>().readString('token');
    final headers = {'Authorization': token};

    var uri = Uri.parse(ServerConfig.baseURL + ServerConfig.editProfile);
    var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);

    request.fields['fullName'] =
        formatNameForBackend(editProfileModel.fullName);
    // request.fields['state'] = editProfileModel.state;

    request.fields['studyInfo'] = editProfileModel.studyInfo;
    request.fields['specInfo'] = editProfileModel.specInfo;
    request.fields['phone'] = editProfileModel.phoneNumber;
    request.fields['gender'] =
        getGenderIntFromString(editProfileModel.gender).toString();
    request.fields['dateOfBirth'] = editProfileModel.dateOfBirth;
    if (kIsWeb) {
      // if (editProfileModel.profilePic != null) {
      //   print("it's web mother fucker");
      //   Uint8List imageBytes = await editProfileModel.profilePic!.readAsBytes();
      //   request.files.add(http.MultipartFile.fromBytes(
      //     'photo',
      //     imageBytes,
      //     filename: editProfileModel.imageName,
      //   ));
      // }
    } else {
      if (editProfileModel.profilePic != null &&
          await editProfileModel.profilePic!.exists()) {
        print(
            "it's not web mother fucker: ${editProfileModel.profilePic!.path}");
        request.files.add(await http.MultipartFile.fromPath(
          'photo',
          editProfileModel.profilePic!.path,
        ));
      }
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    print('editing the profile: ${response.statusCode}');
    print('editing the profile: ${response.body}');

    return response;
  }

  @override
  Future<Response> resetPassword(
    String old,
    String newPassword,
  ) async {
    String token = await sl<PrefService>().readString('token');
    final headers = {'Authorization': token};

    final body = {
      "oldPassword": old,
      "newPassword": newPassword,
    };

    final response = await client.post(
        Uri.parse(ServerConfig.baseURL + ServerConfig.resetPassword),
        body: body,
        headers: headers);
    print('changing the password data source: ${response.statusCode}');
    print('changing the password data source: ${response.body}');
    return response;
  }

  @override
  Future<Response> deleteAccount() async {
    String token = await sl<PrefService>().readString('token');
    final headers = {'Authorization': token};

    final response = await client.delete(
        Uri.parse(ServerConfig.baseURL + ServerConfig.deleteAccountURL),
        headers: headers);
    return response;
  }
}

import 'dart:convert';

import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/gender_for_backend_functions.dart';

import 'package:http/http.dart' as http;
import 'package:graduation_project_therapist_dashboard/app/core/service/shared_preferences.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

abstract class ProfileDataSource {
  Future<int> editProfile(EditProfileModel editProfileModel);
  Future<int> deleteAccount();
  Future<int> resetPassword(
      String old, String newPassword, String recheckNewPassword);
}

class ProfileDataSourceImpl implements ProfileDataSource {
  http.Client client;
  ProfileDataSourceImpl({
    required this.client,
  });

  @override
  Future<int> editProfile(EditProfileModel editProfileModel) async {
    String token = await sl<PrefService>().readString('token');
    final headers = {'Authorization': token};

    var uri = Uri.parse(ServerConfig.baseURL + ServerConfig.editProfile);
    var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);

    request.fields['fullName'] = editProfileModel.fullName;
    request.fields['state'] = editProfileModel.state;
    request.fields['phone'] = editProfileModel.phoneNumber;
    request.fields['gender'] =
        getGenderIntFromString(editProfileModel.gender).toString();
    request.fields['dateOfBirth'] = editProfileModel.dateOfBirth;

    if (editProfileModel.profilePic != null &&
        await editProfileModel.profilePic!.exists()) {
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        editProfileModel.profilePic!.path,
      ));
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        Map<String, dynamic> dataJson = json.decode(response.body);
        final userData = UserProfileModel.fromJson(dataJson['data']);

        sharedPreferences!
            .setString('user_profile', json.encode(userData.toJson()));

        return 200;
      }
      return response.statusCode;
    } catch (e) {
      if (kDebugMode) {
        print('Error in editProfile: $e');
      }
      return 500; // Internal server error code
    }
  }

  @override
  Future<int> resetPassword(
      String old, String newPassword, String recheckNewPassword) async {
    String token = await sl<PrefService>().readString('token');
    final headers = {'Authorization': 'Bearer $token'};

    final body = {
      "oldpassword": old,
      "newpassword": newPassword,
      "c_newpassword": recheckNewPassword,
    };

    final response = await client.post(
        Uri.parse(ServerConfig.baseURL + ServerConfig.resetPassword),
        body: body,
        headers: headers);

    return response.statusCode;
  }

  @override
  Future<int> deleteAccount() async {
    String token = await sl<PrefService>().readString('token');
    final headers = {'Authorization': 'Bearer $token'};

    final response = await client.post(
        Uri.parse(ServerConfig.baseURL + ServerConfig.deleteAccountURL),
        headers: headers);
    return response.statusCode;
  }
}

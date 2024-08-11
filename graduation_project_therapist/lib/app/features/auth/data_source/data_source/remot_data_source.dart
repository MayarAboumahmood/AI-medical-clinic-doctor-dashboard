import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/notification_service.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http_parser/http_parser.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/model/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class AuthRemoteDataSource {
  Future<Response> register(
      UserInfo registerModel, Uint8List? imageBytes, String? imageName);
  Future<Response> login(String userEmail, String password);
  sendOTPCode(String userEmail, String otpToken);

  Future<Response> forgetPasswordChangePasswordCode(
      String newPassword, String otpCode);

  Future<Response> sendEmailToGetOtp(String userEmail);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  http.Client client;
  AuthRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<Response> register(
      UserInfo registerModel, Uint8List? imageBytes, String? imageName) async {
    String deviceToken = await pushyRegister();

    print('the device token: $deviceToken');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ServerConfig.url + ServerConfig.register),
    );

    request.headers.addAll(
      {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );

    bool isDateOFBirthExist = registerModel.dateOfBirth != null &&
        registerModel.dateOfBirth?.trim() != '';
    // Add text fields
    request.fields['deviceToken'] = deviceToken;
    request.fields['fullName'] =
        '${registerModel.firstName.trim()} ${registerModel.lastName.trim()}';
    request.fields['email'] = registerModel.userEmail.trim();
    request.fields['phone'] = registerModel.phoneNumber.trim();
    request.fields['password'] = registerModel.password.trim();
    request.fields['roleId'] = registerModel.roleId.toString();
    request.fields['dateOfBirth'] = isDateOFBirthExist
        ? registerModel.dateOfBirth!
        : DateFormat('yyyy-MM-dd').format(DateTime(2001, 1, 1));
    request.fields['gender'] = registerModel.gender.toString();

    // Add image if available
    if (imageBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes('photo', imageBytes,
            filename: imageName ?? 'image.jpg',
            contentType: MediaType('image', 'jpeg')),
      );
    }

    // Send the request
    final response = await request.send();

    final responseBody = await response.stream.bytesToString();
    debugPrint('in the register datasource: $responseBody');
    debugPrint('in the register datasource: ${response.statusCode}');
    debugPrint(
        'in the register datasource: ${registerModel.firstName.trim()} ${registerModel.lastName.trim()}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      sharedPreferences!
          .setString('doctorOrTherapist', registerModel.roleId.toString());
      isGuest = false;
      return http.Response(responseBody, response.statusCode);
    } else if (response.statusCode != 500) {
      return http.Response(responseBody, response.statusCode);
    } else {
      return http.Response('ServerError', response.statusCode);
    }
  }

  @override
  Future<Response> sendOTPCode(String userEmail, String otpToken) async {
    var url = Uri.parse(ServerConfig.url + ServerConfig.otpVerify);
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'token': otpToken,
    });
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedResponse = jsonDecode(response.body);
      String accessToken = decodedResponse['data']['accessToken'];
      sharedPreferences!.setBool('isRegisterCompleted', true);
      // Storing the access token in shared preferences
      sharedPreferences!.setString('token', accessToken);
      return http.Response(response.body, response.statusCode);
    } else if (response.statusCode != 500) {
      return http.Response(response.body, response.statusCode);
    } else {
      return http.Response(response.body, response.statusCode);
    }
  }

  @override
  Future<http.Response> login(String userEmail, String password) async {
    var url = Uri.parse(ServerConfig.url + ServerConfig.login);
    var headers = {
      'Content-Type': 'application/json',
    };
    String deviceToken = await pushyRegister();

    print('the device token: $deviceToken');

    var body = jsonEncode({
      'email': userEmail.trim(),
      'deviceToken': deviceToken,
      'password': password.trim(),
    });
    var response = await http.post(url, headers: headers, body: body);
    debugPrint('login response body: ${response.body}');
    debugPrint('login response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedResponse = jsonDecode(response.body);
      isGuest = false;
      String accessToken = decodedResponse['data']['accessToken'];
      sharedPreferences!.setBool('isRegisterCompleted', true);
      sharedPreferences!.setString(
          'doctorOrTherapist', (decodedResponse['data']['roleId']).toString());

      sharedPreferences!.setString('token', accessToken);

      return http.Response(response.body, response.statusCode);
    } else if (response.statusCode != 500) {
      return http.Response(response.body, response.statusCode);
    } else {
      return http.Response(response.body, response.statusCode);
    }
  }

  @override
  Future<http.Response> forgetPasswordChangePasswordCode(
      String newPassword, String otpCode) async {
    var url =
        Uri.parse(ServerConfig.url + ServerConfig.passwordforgotChangePassword);
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'newPassword': newPassword.trim(),
      'token': otpCode,
    });
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return http.Response(response.body, response.statusCode);
    } else if (response.statusCode != 500) {
      return http.Response(response.body, response.statusCode);
    } else {
      return http.Response(response.body, response.statusCode);
    }
  }

  @override
  Future<http.Response> sendEmailToGetOtp(String userEmail) async {
    var url = Uri.parse(ServerConfig.url + ServerConfig.sendOTP);
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'email': userEmail.trim(),
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return http.Response(response.body, response.statusCode);
    } else if (response.statusCode != 500) {
      return http.Response(response.body, response.statusCode);
    } else {
      return http.Response(response.body, response.statusCode);
    }
  }
}

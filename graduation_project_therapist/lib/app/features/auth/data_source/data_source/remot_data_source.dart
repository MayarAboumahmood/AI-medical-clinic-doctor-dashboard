import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http_parser/http_parser.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/model/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class AuthRemoteDataSource {
  Future<Response> register(UserInfo registerModel, Uint8List? imageBytes);
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
      UserInfo registerModel, Uint8List? imageBytes) async {
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
    request.fields['fullName'] =
        '${registerModel.firstName} ${registerModel.lastName}';
    request.fields['email'] = registerModel.userEmail.trim();
    request.fields['phone'] = registerModel.phoneNumber.trim();
    request.fields['password'] = registerModel.password.trim();
    request.fields['roleId'] = registerModel.roleId.toString();
    request.fields['dateOfBirth'] = isDateOFBirthExist
        ? registerModel.dateOfBirth!
        : DateFormat('yyyy/MM/dd').format(DateTime(2001, 1, 1));
    request.fields['gender'] = registerModel.gender.toString();

    // Add image if available
    if (imageBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes('photo', imageBytes,
            filename: 'profile_image', contentType: MediaType('image', 'jpeg')),
      );
    }

    // Send the request
    final response = await request.send();

    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201 || response.statusCode == 200) {
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
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
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
    var body = jsonEncode({
      'email': userEmail.trim(),
      'password': password.trim(),
    });
    var response = await http.post(url, headers: headers, body: body);
    print('login Status Code: ${response.statusCode}');
    print('login Response Body: $body');
    print('login Response Body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedResponse = jsonDecode(response.body);
      String accessToken = decodedResponse['data']['accessToken'];
      sharedPreferences!.setBool('isRegisterCompleted', true);
      print('login Response Body token: $accessToken');

      sharedPreferences!.setString('token', accessToken);
      print(
          'login Response Body token: ${sharedPreferences!.getString('token')}');

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
    print('the otp is in forget pass: $otpCode');
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
    print('changing password statuscode: ${response.statusCode}');
    print('changing password Body: $body');
    print('changing password local Body: ${response.body}');
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
    print('changing password sending email Body: $body');

    var response = await http.post(url, headers: headers, body: body);
    print('changing password sending email statuscode: ${response.statusCode}');
    print('changing password sending email local Body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return http.Response(response.body, response.statusCode);
    } else if (response.statusCode != 500) {
      return http.Response(response.body, response.statusCode);
    } else {
      return http.Response(response.body, response.statusCode);
    }
  }
}

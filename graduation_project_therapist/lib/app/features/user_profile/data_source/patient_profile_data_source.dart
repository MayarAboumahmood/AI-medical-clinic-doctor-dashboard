import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PatientProfileDataSource {
  http.Client client;
  PatientProfileDataSource({required this.client});

  Future<Response> getPatientsProfile(int userID) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        '${ServerConfig.url}${ServerConfig.getPatientsProfileUri}$userID/profile');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('geting patient profile datasource: ${response.body}');
    debugPrint('geting patient profile datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> assignPatientToTherapist(
      int patientID, int therapistID) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url =
        Uri.parse(ServerConfig.url + ServerConfig.assignPatientToTherapistUri);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {"userId": patientID.toString(), "specId": therapistID.toString()},
      headers: headers,
    );
    debugPrint('assign Patient To Therapist datasource: ${response.body}');
    debugPrint(
        'assign Patient To Therapist datasource: ${response.statusCode}');
    return response;
  }
}

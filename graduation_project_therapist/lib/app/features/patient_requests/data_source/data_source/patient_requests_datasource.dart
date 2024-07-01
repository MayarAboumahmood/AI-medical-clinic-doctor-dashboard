import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PatientRequestsDataSource {
  http.Client client;
  PatientRequestsDataSource({required this.client});

  Future<Response> getPatientRequests() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getPatientrequestUri);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('patient request therapist datasource token token: $token');
    debugPrint('patient request therapist datasource: ${response.body}');
    debugPrint('patient request therapist datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> acceptPatientRequest(
      int requestId, String date, String time) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        '${ServerConfig.url}${ServerConfig.acceptPatientrequest}$requestId/set-date');
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {'date': "$date $time"},
      headers: headers,
    );

    print('accept patient request response ssssssssssssssssssss: ${url}');
    print(
        'accept patient request response ssssssssssssssssssss: ${url.toString()}');
    print(
        'accept patient request response ssssssssssssssssssss: $date + $time');
    print(
        'accept patient request response ssssssssssssssssssss: ${response.statusCode}');
    print(
        'accept patient request response ssssssssssssssssssss: ${response.body}');
    return response;
  }

  Future<Response> rejectPatientRequest(int requestId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        '${ServerConfig.url}${ServerConfig.rejectPatientrequest}$requestId/reject');
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      headers: headers,
    );

    print(
        'reject patient request response ssssssssssssssssssss: ${response.statusCode}');
    print(
        'reject patient request response ssssssssssssssssssss: ${response.body}');
    return response;
  }
}

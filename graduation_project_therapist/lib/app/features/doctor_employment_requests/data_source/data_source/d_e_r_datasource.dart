import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DoctorEmploymentDataSource {
  http.Client client;
  DoctorEmploymentDataSource({required this.client});

  Future<Response> getAllDoctorEmploymentRequests() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        ServerConfig.url + ServerConfig.getAllDoctorEmploymentRequests);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint(
        'geting all Doctor employment request datasource: ${response.body}');
    debugPrint(
        'geting all Doctor employment request datasource: ${response.statusCode}');
    return response;
  }

  approveDoctorEmploymentRequest(int therapistId, bool status) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        '${ServerConfig.url}specs/employmentRequests/${therapistId.toString()}/approval');
    var headers = {'Authorization': token};

    var response = await http.put(
      url,
      body: {'status': "$status"},
      headers: headers,
    );
    print('the response aprove doctor emp request data source:$status');
    print(
        'the response aprove doctor emp request data source:${response.statusCode}');
    print(
        'the response aprove doctor emp request data source:${response.body}');
    return response;
  }
}

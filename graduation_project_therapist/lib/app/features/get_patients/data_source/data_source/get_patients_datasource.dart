import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetPatientsDataSource {
  http.Client client;
  GetPatientsDataSource({required this.client});

  Future<Response> getPatients() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getPatientsUri);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('geting my patients datasource: ${response.body}');
    debugPrint('geting my patients datasource: ${response.statusCode}');
    return response;
  }

}

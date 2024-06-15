import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetAllTherapistDataSource {
  http.Client client;
  GetAllTherapistDataSource({required this.client});

  Future<Response> getAllTherapist() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getAllTherapists);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('geting all therapist datasource: ${response.body}');
    debugPrint('geting all therapist datasource: ${response.statusCode}');
    return response;
  }

  assignTherapist(int therapistId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.assignTherapist);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {'userId': therapistId.toString()},
      headers: headers,
    );

    print('response ssssssssssssssssssss: ${response.statusCode}');
    print('response ssssssssssssssssssss: ${response.body}');
    return response;
  }

  Future<Response> getMyTherapist() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getMyTherapists);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }

  removeTherapist(int therapistId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        '${ServerConfig.url}${ServerConfig.removeTherapist}${therapistId.toString()}/remove');
    var headers = {'Authorization': token};
    var response = await http.delete(
      url,
      headers: headers,
    );

    debugPrint('geting my therapist datasource: ${response.body}');
    debugPrint('geting my therapist datasource: ${response.statusCode}');
    return response;
  }
}

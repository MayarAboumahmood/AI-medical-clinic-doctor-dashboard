import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WalletDataSource {
  http.Client client;
  WalletDataSource({required this.client});

  Future<Response> getHistory() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getHistory);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }

  removeTherapist(int therapistId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.assignTherapist);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {'userId': therapistId.toString()},
      headers: headers,
    );

    debugPrint('geting my therapist datasource: ${response.body}');
    debugPrint('geting my therapist datasource: ${response.statusCode}');
    return response;
  }
}

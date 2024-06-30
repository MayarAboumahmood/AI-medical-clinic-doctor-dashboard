import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ChatDataSource {
  http.Client client;
  ChatDataSource({required this.client});

  Future<Response> getChatInformation(int patientId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        ServerConfig.url + ServerConfig.getChatInfoUri + patientId.toString());
    var headers = {'Authorization': token};
    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('chat info Description tttttttttttttttttttt: ${token}');
    debugPrint('chat info Description datasource: ${response.body}');
    debugPrint('chat info Description datasource: ${response.statusCode}');
    return response;
  }
}

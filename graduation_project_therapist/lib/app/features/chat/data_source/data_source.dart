import 'dart:typed_data';

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
    print('chat info Description datasource: ${response.body}');
    print('chat info Description datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> sendCompleteSession(int appointmentId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.videoCallCompleteUri);
    var headers = {'Authorization': token};
    var response = await http.post(
      url,
      body: {"appointmentId": appointmentId.toString()},
      headers: headers,
    );
    debugPrint('video Call Complete datasource: ${response.body}');
    debugPrint('video Call Complete datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> checkIfSessionComplete(int appointmentId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url +
        ServerConfig.checkIfSessionCompleteUri +
        appointmentId.toString());
    var headers = {'Authorization': token};
    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint(
        'video Call check If Session Complete datasource: ${response.body}');
    debugPrint(
        'video Call check If Session Complete Complete datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> reportVideoCall(
      int appointmentId, String description, Uint8List pic) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.reportVideoCallUri);
    var headers = {'Authorization': token};

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['description'] = description
      ..fields['appointmentId'] = appointmentId.toString()
      ..files.add(http.MultipartFile.fromBytes(
        'pic',
        pic,
        filename: 'image.jpg',
      ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    debugPrint('report Video Call datasource: ${response.body}');
    debugPrint('report Video Call datasource: ${response.statusCode}');
    return response;
  }

  sendToBackendForNotification(
      int patientID, String userName, String type) async {
    String token = sharedPreferences!.getString('token') ?? '';
    print('patientID: $patientID');
    print('userName: $userName');
    print('type: $type');
    var url = Uri.parse(
        ServerConfig.url + ServerConfig.sendToBackendForNotificationUrl);
    var headers = {'Authorization': token};
    var response = await http.post(
      url,
      body: {
        "userId": patientID.toString(),
        "senderName": userName,
        "type": type
      },
      headers: headers,
    );
    debugPrint(
        'send to backend to send notification datasource: ${response.body}');
    debugPrint(
        'send to backend to send notification datasource: ${response.statusCode}');
    return response;
  }
}

import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_description_model.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MedicalDescriptionSource {
  http.Client client;
  MedicalDescriptionSource({required this.client});

  Future<Response> createMedicalDescription(
      MedicalDescriptionModel medicalDescriptionModel) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url =
        Uri.parse(ServerConfig.url + ServerConfig.createMedicalRecordsUri);
    var headers = {'Authorization': token};
    var body = medicalDescriptionModel.toMap();
    var response = await http.post(
      url,
      body: body,
      headers: headers,
    );
    debugPrint('create Medical Description datasource: $body');
    debugPrint('create Medical Description datasource: ${response.body}');
    debugPrint('create Medical Description datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> getAllMedicalRecords(int patientId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        '${ServerConfig.url}${ServerConfig.getAllMedicalRecordsUri}$patientId');
    var headers = {'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('get all Medical Description datasource: ${response.body}');
    debugPrint(
        'get all Medical Description datasource: ${response.statusCode}');
    return response;
  }

  getMedicalDescriptionDetails(int medicalDescriptionID) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(
        '${ServerConfig.url}${ServerConfig.getMedicalRecordDetailsUri}$medicalDescriptionID');
    var headers = {'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('get Medical Description details datasource: ${response.body}');
    debugPrint(
        'get Medical Description details datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> editMedicalDescription(
      MedicalDescriptionModel medicalDescriptionModel,
      int medicalDescriptionId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url +
        ServerConfig.editMedicalRecordsUri +
        medicalDescriptionId.toString());
    var headers = {'Authorization': token};
    var body = medicalDescriptionModel.toMapWithoutID();
    var response = await http.put(
      url,
      body: body,
      headers: headers,
    );
    debugPrint('edit Medical Description datasource: $body');
    debugPrint('edit Medical Description datasource: ${response.body}');
    debugPrint('edit Medical Description datasource: ${response.statusCode}');
    return response;
  }
}

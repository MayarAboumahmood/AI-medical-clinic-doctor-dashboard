import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PatientReservationsDataSource {
  http.Client client;
  PatientReservationsDataSource({required this.client});

  Future<Response> getPatientReservations() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getAppointmentsuri);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint('geting all PatientReservations datasource: ${response.body}');
    debugPrint(
        'geting all PatientReservations datasource: ${response.statusCode}');
    return response;
  }
}

import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BlockDataSource {
  http.Client client;
  BlockDataSource({required this.client});

  Future<Response> blockPatient(int patientId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.blockPatienturi);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {
        "userId": patientId.toString(),
      },
      headers: headers,
    );
    print('block user body datasource: ${response.body}');
    print('block user status statuscode datasource: ${response.statusCode}');

    return response;
  }

  Future<Response> unBlockPatient(int patientId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.unBlockPatienturi);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {
        "userId": patientId.toString(),
      },
      headers: headers,
    );
    print('unblock user body datasource: ${response.body}');
    print('unblock user status statuscode datasource: ${response.statusCode}');

    return response;
  }

  Future<Response> getAllBlocedPatientEvent() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.blockPatienturi);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    print('get All Bloced Patient status body datasource: ${response.body}');
    print(
        'get All Bloced Patient statuscode datasource: ${response.statusCode}');

    return response;
  }

  Future<Response> reportPatient(int patientId, String description) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.reportPatientUri);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {'userId': patientId.toString(), 'description': description},
      headers: headers,
    );
    print('report Patient status body datasource: ${response.body}');
    print('report Patient statuscode datasource: ${response.statusCode}');

    return response;
  }

  Future<Response> reportMedicalDescription(
      int medicalDescriptionId, String description) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.reportMedicalRecordUri);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {
        'medicalRecordId': medicalDescriptionId.toString(),
        'description': description
      },
      headers: headers,
    );
    print('report Patient status body datasource: ${description}');
    print('report Patient status body datasource: ${response.body}');
    print('report Patient statuscode datasource: ${response.statusCode}');

    return response;
  }
}

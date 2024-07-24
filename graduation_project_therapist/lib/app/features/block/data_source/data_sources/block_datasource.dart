import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BlockDataSource {
  http.Client client;
  BlockDataSource({required this.client});

  Future<Response> getUserProfileData() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getUserInfourl);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );

    print('getint user profile body datasource: ${response.body}');
    print('getint user profile statuscode datasource: ${response.statusCode}');
    return response;
  }

  Future<Response> blockPatient(int patientId) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.blockPatienturi);
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.post(
      url,
      body: {
        "userId": patientId,
      },
      headers: headers,
    );
    print('getint user status body datasource: ${response.body}');
    print('getint user status statuscode datasource: ${response.statusCode}');

    return response;
  }
}

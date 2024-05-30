import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePageDataSource {
  http.Client client;
  HomePageDataSource({required this.client});

  Future<Response> getUserProfileData() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getUserInfourl);
    var headers = {'Content-Type': 'application/json', 'token': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    print('get user profile Status Code: ${response.statusCode}');

    print('get user profile Response Body: ${response.body}');
    return response;
  }

  Future<Response> getUserStatusData() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getUserStatus);
    var headers = {'Content-Type': 'application/json', 'token': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    print('get user profile Status Code: ${response.statusCode}');

    print('get user profile Response Body: ${response.body}');
    return response;
  }
}

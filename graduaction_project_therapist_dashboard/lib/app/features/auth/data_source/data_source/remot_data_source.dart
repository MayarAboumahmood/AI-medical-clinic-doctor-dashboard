import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  // Future<Response> register(RegisterModel registerModel);
  }

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  http.Client client;
  AuthRemoteDataSourceImpl({
    required this.client,
  });

  /*@override
  Future<Response> register(RegisterModel registerModel) async {
    final body = {
      "firstname": registerModel.firstName,
      "lastname": registerModel.lastName,
      "email": registerModel.email,
      "phone": registerModel.phoneNumber,
    };

    final response = await client.post(
        Uri.parse(ServerConfig.baseURL + ServerConfig.register),
        body: body);
    return response;
  }
*/
}

import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WalletDataSource {
  http.Client client;
  WalletDataSource({required this.client});

  Future<Response> getTransactionHistory() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getHistory);
    var headers = {'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint(
        'get transaction history in the data source: ${response.statusCode}');
    debugPrint('get transaction history in the data source: ${response.body}');
    return response;
  }

  Future<Response> makeRequestToGetMoney(String amountOfMoney) async {
    debugPrint('makeRequestToGetMoney in the data source: first');

    String token = sharedPreferences!.getString('token') ?? '';
    var url =
        Uri.parse(ServerConfig.url + ServerConfig.makeRequestToGetMoneyUri);
    var headers = {'Authorization': token};

    var response = await http.post(
      url,
      body: {'amount': amountOfMoney},
      headers: headers,
    );
    debugPrint(
        'makeRequestToGetMoney in the data source: ${response.statusCode}');
    debugPrint(' makeRequestToGetMoney in the data source: ${response.body}');

    return response;
  }

  Future<Response> getAvailableFunds() async {
    String token = sharedPreferences!.getString('token') ?? '';
    var url = Uri.parse(ServerConfig.url + ServerConfig.getAvailableFundsuri);
    var headers = {'Authorization': token};

    var response = await http.get(
      url,
      headers: headers,
    );
    debugPrint(' getAvailableFunds the data source: ${response.statusCode}');
    debugPrint(' getAvailableFunds in the data source: ${response.body}');

    return response;
  }
}

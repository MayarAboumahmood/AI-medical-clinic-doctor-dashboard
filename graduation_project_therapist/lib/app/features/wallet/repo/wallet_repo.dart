import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/data_source/wallet_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/models/wallet_history_model.dart';

class WalletRepositoryImp {
  final WalletDataSource _walletDataSource;

  WalletRepositoryImp(this._walletDataSource);
  Future<Either<String, List<WalletHistoryModel>>>
      getTransactionHistory() async {
    try {
      final response = await _walletDataSource.getTransactionHistory();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> requests = decodedResponse['data']['requests'];
        final List<WalletHistoryModel> walletHistory = requests
            .map((item) =>
                WalletHistoryModel.fromMap(item as Map<String, dynamic>))
            .toList();
        return right(walletHistory);
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get Transaction History repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> makeRequestToGetMoney(
      String amountOfMoney) async {
    try {
      final response =
          await _walletDataSource.makeRequestToGetMoney(amountOfMoney);
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right('done');
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get make request to get money repo: $e');
      return left('Server Error');
    }
  }

  Future<Either<String, String>> getAvailableFunds() async {
    try {
      final response = await _walletDataSource.getAvailableFunds();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right((decodedResponse['data']['balance']).toString());
      } else if (response.statusCode == 500) {
        if (decodedResponse['error'] == 'jwt expired') {
          return left('jwt expired');
        }
        return left('Server error');
      } else {
        return left(decodedResponse['error']);
      }
    } catch (e) {
      debugPrint('error in get Available Funds repo: $e');
      return left('Server Error');
    }
  }
}

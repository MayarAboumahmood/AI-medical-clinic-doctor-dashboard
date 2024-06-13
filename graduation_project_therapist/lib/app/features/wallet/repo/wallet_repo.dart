import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/data_source/wallet_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/models/wallet_history_model.dart';

class WalletRepositoryImp {
  final WalletDataSource _walletDataSource;

  WalletRepositoryImp(this._walletDataSource);
  Future<Either<String, List<WalletHistoryModel>>> getMyTherapist() async {
    try {
      final response = await _walletDataSource.getHistory();
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = decodedResponse['data'];
        final List<WalletHistoryModel> walletHistory =
            data.map((item) => WalletHistoryModel.fromMap(item)).toList();
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
      debugPrint('error in get all therapist repo: $e');
      return left('Server Error');
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/models/wallet_history_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/repo/wallet_repo.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepositoryImp walletRepositoryImp;
  WalletCubit({required this.walletRepositoryImp}) : super(WalletInitial());
  List<WalletHistoryModel> transactionHistory = [];
  TextEditingController amountTextController = TextEditingController();
  void getTransactionHistory() async {
    emit(WalletGetHistoryLoadingState());
    final getData = await walletRepositoryImp.getTransactionHistory();
    getData.fold(
        (errorMessage) =>
            emit(WalletGetHistoryErrorState(errorMessage: errorMessage)),
        (transactionHistory) {
      this.transactionHistory = transactionHistory;
      print('get data in the cubit: ${transactionHistory.length}');
      emit(WalletGetHistorySuccessfullyState());
    });
  }

  void makeRequestToGetMoney() async {
    emit(WalletRequestToGetMoneyLoadingState());
    final getData = await walletRepositoryImp
        .makeRequestToGetMoney(amountTextController.text);
    getData.fold(
        (errorMessage) =>
            emit(WalletRequestToGetMoneyErrorState(errorMessage: errorMessage)),
        (done) {
      emit(WalletRequestToGetMoneySuccessfullyState());
    });
  }

  void getAvailableFunds() async {
    emit(WalletGetAvailableFundsLoadingState());
    final getData = await walletRepositoryImp.getAvailableFunds();
    getData.fold(
        (errorMessage) =>
            emit(WalletAvailableFundsErrorState(errorMessage: errorMessage)),
        (availableFunds) {
      emit(WalletAvailableFundsSuccessfullyState(
          availableFunds: availableFunds));
    });
  }
}

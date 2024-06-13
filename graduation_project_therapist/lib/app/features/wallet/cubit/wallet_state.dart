part of 'wallet_cubit.dart';

@immutable
sealed class WalletState extends Equatable {}

final class WalletInitial extends WalletState {
  @override
  List<Object?> get props => [];
}

//....................................//
final class WalletRequestToGetMoneyLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

final class WalletRequestToGetMoneyErrorState extends WalletState {
  final String errorMessage;
  WalletRequestToGetMoneyErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class WalletRequestToGetMoneySuccessfullyState extends WalletState {
  @override
  List<Object?> get props => [];
}

//....................................//
final class WalletGetHistoryLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

final class WalletGetHistoryErrorState extends WalletState {
  final String errorMessage;
  WalletGetHistoryErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class WalletGetHistorySuccessfullyState extends WalletState {
  @override
  List<Object?> get props => [];
}

//....................................//
final class WalletGetAvailableFundsLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

final class WalletAvailableFundsSuccessfullyState extends WalletState {
  final String availableFunds;
  WalletAvailableFundsSuccessfullyState({required this.availableFunds});
  @override
  List<Object?> get props => [availableFunds];
}

final class WalletAvailableFundsErrorState extends WalletState {
  final String errorMessage;
  WalletAvailableFundsErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

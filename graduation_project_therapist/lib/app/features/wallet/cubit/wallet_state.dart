part of 'wallet_cubit.dart';

@immutable
sealed class WalletState extends Equatable {}

final class WalletInitial extends WalletState {
  @override
  List<Object?> get props => [];
}

final class WalletGetMoneyRequestLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

final class WalletGetHistoryLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

final class WalletGetRemaininAmountLoadingState extends WalletState {
  @override
  List<Object?> get props => [];
}

final class WalletRemaininAmountLoadedState extends WalletState {
  final String remainingMoneyAmount;
  WalletRemaininAmountLoadedState({required this.remainingMoneyAmount});
  @override
  List<Object?> get props => [remainingMoneyAmount];
}
final class WalletRemaininAmountErrorState extends WalletState {
  final String errorMessage;
  WalletRemaininAmountErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

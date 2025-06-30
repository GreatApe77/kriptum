part of 'reset_wallet_bloc.dart';

sealed class ResetWalletState {}

final class ResetWalletInitial extends ResetWalletState {}

final class ResetWalletInProgress extends ResetWalletState {}

final class ResetWalletSuccess extends ResetWalletState {}

final class ResetWalletFailure extends ResetWalletState {
  final String error;

  ResetWalletFailure(this.error);
}

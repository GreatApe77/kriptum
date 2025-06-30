part of 'unlock_wallet_bloc.dart';

sealed class UnlockWalletState {}

final class UnlockWalletInitial extends UnlockWalletState {}

final class UnlockWalletInProgress extends UnlockWalletState {}

final class UnlockWalletSuccess extends UnlockWalletState {}

final class UnlockWalletFailure extends UnlockWalletState {
  final String errorMessage;

  UnlockWalletFailure({
    required this.errorMessage,
  });
}

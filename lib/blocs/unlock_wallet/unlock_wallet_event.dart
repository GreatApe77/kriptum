part of 'unlock_wallet_bloc.dart';

sealed class UnlockWalletEvent {}

final class UnlockWalletRequested extends UnlockWalletEvent {
  final String password;

  UnlockWalletRequested(this.password);
}

part of 'lock_wallet_bloc.dart';

sealed class LockWalletState {}

final class LockWalletInitial extends LockWalletState {}

final class LockWalletSuccess extends LockWalletState {}

final class LockWalletError extends LockWalletState {
  final String errorMessage;

  LockWalletError({required this.errorMessage});
}

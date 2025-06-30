part of 'add_hd_wallet_account_bloc.dart';

sealed class AddHdWalletAccountState {}

final class AddHdWalletAccountInitial extends AddHdWalletAccountState {}

final class AddHdWalletAccountLoading extends AddHdWalletAccountState {}

final class AddHdWalletAccountError extends AddHdWalletAccountState {
  final String message;

  AddHdWalletAccountError({required this.message});
}

final class AddHdWalletAccountSuccess extends AddHdWalletAccountState {}

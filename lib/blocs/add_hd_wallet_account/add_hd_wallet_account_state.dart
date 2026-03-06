part of 'add_hd_wallet_account_bloc.dart';

sealed class AddHdWalletAccountState {}

final class AddHdWalletAccountInitial extends AddHdWalletAccountState {}

final class AddHdWalletAccountLoading extends AddHdWalletAccountState {}

final class AddHdWalletAccountError extends AddHdWalletAccountState {
  final Exception error;

  AddHdWalletAccountError({required this.error});
}

final class AddHdWalletAccountSuccess extends AddHdWalletAccountState {}

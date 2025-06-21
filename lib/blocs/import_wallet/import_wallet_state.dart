part of 'import_wallet_bloc.dart';

sealed class ImportWalletState {}

final class ImportWalletInitial extends ImportWalletState {}

final class ImportWalletLoading extends ImportWalletState {}

final class ImportWalletSuccess extends ImportWalletState {}

final class ImportWalletFailed extends ImportWalletState {
  final String reason;

  ImportWalletFailed({required this.reason});
}

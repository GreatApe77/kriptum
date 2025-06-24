part of 'import_wallet_bloc.dart';

sealed class ImportWalletEvent {}

final class ImportWalletRequested extends ImportWalletEvent {
  final String mnemonicPhrase;
  final String password;

  ImportWalletRequested({
    required this.mnemonicPhrase,
    required this.password,
  });
}

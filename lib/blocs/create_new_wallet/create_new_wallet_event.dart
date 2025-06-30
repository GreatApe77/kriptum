part of 'create_new_wallet_bloc.dart';

sealed class CreateNewWalletEvent {}

class PasswordChangedEvent extends CreateNewWalletEvent {
  final String password;

  PasswordChangedEvent({required this.password});
}

class ConfirmPasswordChangedEvent extends CreateNewWalletEvent {
  final String confirmPassword;

  ConfirmPasswordChangedEvent({required this.confirmPassword});
}

class AdvanceToStep2Event extends CreateNewWalletEvent {}

class AdvanceToStep3Event extends CreateNewWalletEvent {}

class ConfirmBackupEvent extends CreateNewWalletEvent {}

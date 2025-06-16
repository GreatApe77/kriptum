// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_new_wallet_bloc.dart';

class CreateNewWalletState {
  final int step;
  final String errorMessage;
  final CreateNewWalletStatus status;
  final String mnemonic;
  final String password;
  final String confirmPassword;
  final List<Account> accounts;

  CreateNewWalletState({
    required this.step,
    required this.errorMessage,
    required this.status,
    required this.mnemonic,
    required this.password,
    required this.confirmPassword,
    required this.accounts,
  });
  factory CreateNewWalletState.initial() {
    return CreateNewWalletState(
      step: 1,
      errorMessage: '',
      status: CreateNewWalletStatus.initial,
      mnemonic: '',
      password: '',
      confirmPassword: '',
      accounts: [],
    );
  }

  CreateNewWalletState copyWith({
    int? step,
    String? errorMessage,
    CreateNewWalletStatus? status,
    String? mnemonic,
    String? password,
    String? confirmPassword,
    List<Account>? accounts,
  }) {
    return CreateNewWalletState(
      step: step ?? this.step,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      mnemonic: mnemonic ?? this.mnemonic,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      accounts: accounts ?? this.accounts,
    );
  }
}

enum CreateNewWalletStatus {
  initial,
  loading,
  success,
  failure,
}

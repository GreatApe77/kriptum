part of 'account_list_bloc.dart';

class AccountListState {
  final List<Account> accounts;
  final String errorMessage;

  AccountListState({required this.accounts, required this.errorMessage});

  AccountListState copyWith({
    List<Account>? accounts,
    String? errorMessage,
  }) {
    return AccountListState(
      accounts: accounts ?? this.accounts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AccountListState.initial() {
    return AccountListState(
      accounts: [],
      errorMessage: '',
    );
  }
}

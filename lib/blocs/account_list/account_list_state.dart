part of 'account_list_bloc.dart';

class AccountListState {
  final List<Account> accounts;
  final Exception? accountListError;

  AccountListState({required this.accounts, required this.accountListError});

  AccountListState copyWith({
    List<Account>? accounts,
    Exception? accountListError,
  }) {
    return AccountListState(
      accounts: accounts ?? this.accounts,
      accountListError: accountListError ?? this.accountListError,
    );
  }

  factory AccountListState.initial() {
    return AccountListState(
      accounts: [],
      accountListError: null,
    );
  }
}

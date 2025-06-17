part of 'account_list_bloc.dart';

class AccountListState {
  final List<Account> accounts;

  AccountListState({required this.accounts});

  AccountListState copyWith({
    List<Account>? accounts,
  }) {
    return AccountListState(
      accounts: accounts ?? this.accounts,
    );
  }

  factory AccountListState.initial() {
    return AccountListState(accounts: []);
  }
}

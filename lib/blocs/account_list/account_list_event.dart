part of 'account_list_bloc.dart';

sealed class AccountListEvent {}

final class AccountListRequested extends AccountListEvent {}

final class AccountsListUpdated extends AccountListEvent {
  final Account updatedAccount;

  AccountsListUpdated({
    required this.updatedAccount,
  });
}
final class _AccountsListRefreshed extends AccountListEvent {
  final List<Account> accounts;

  _AccountsListRefreshed({
    required this.accounts,
  });
}
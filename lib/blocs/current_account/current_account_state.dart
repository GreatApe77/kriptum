// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_account_bloc.dart';

class CurrentAccountState {
  final Account? account;

  CurrentAccountState({required this.account});

  CurrentAccountState copyWith({
    Account? account,
  }) {
    return CurrentAccountState(
      account: account ?? this.account,
    );
  }

  factory CurrentAccountState.initial() {
    return CurrentAccountState(account: null);
  }
}

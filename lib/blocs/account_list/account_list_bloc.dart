import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  final AccountsRepository _accountsRepository;
  late final StreamSubscription<List<Account>> _accountsSubscription;
  AccountListBloc(
    this._accountsRepository,
  ) : super(AccountListState.initial()) {
    _accountsSubscription = _accountsRepository.watchAccounts().listen(
      (event) {
        add(
          _AccountsListRefreshed(accounts: event),
        );
      },
    );
    on<_AccountsListRefreshed>((event, emit) {
      emit(
        state.copyWith(accounts: event.accounts),
      );
    });
    on<AccountListRequested>((event, emit) async {
      try {
        final accounts = await _accountsRepository.getAccounts();
        emit(
          state.copyWith(accounts: accounts),
        );
      } catch (e) {
        emit(
          state.copyWith(accounts: []),
        );
      }
    });
    on<AccountsListUpdated>(
      (event, emit) async {
        final updatedAccount = event.updatedAccount;
        try {
          await _accountsRepository.updateAccount(updatedAccount);
        } catch (e) {
          emit(
            state.copyWith(
              errorMessage: 'Failed to update account.',
            ),
          );
        }
      },
    );
  }
  @override
  Future<void> close() {
    _accountsSubscription.cancel();
    return super.close();
  }
}

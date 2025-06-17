import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';

part 'current_account_event.dart';
part 'current_account_state.dart';

class CurrentAccountBloc
    extends Bloc<CurrentAccountEvent, CurrentAccountState> {
  final AccountsRepository _accountsRepository;
  late StreamSubscription<Account?> _accountSubscription;

  CurrentAccountBloc(this._accountsRepository)
      : super(CurrentAccountState.initial()) {
    _accountSubscription = _accountsRepository.currentAccountStream().listen(
      (account) {
        add(
          CurrentAccountChanged(account: account!),
        );
      },
    );
    on<CurrentAccountRequested>(
      (event, emit) async {
        try {
          final account = await _accountsRepository.getCurrentAccount();
          emit(
            CurrentAccountState(account: account),
          );
        } catch (e) {
          emit(CurrentAccountState(account: null));
        }
      },
    );
    on<CurrentAccountChanged>((event, emit) {
      emit(
        CurrentAccountState(
          account: event.account,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _accountSubscription.cancel();
    return super.close();
  }
}

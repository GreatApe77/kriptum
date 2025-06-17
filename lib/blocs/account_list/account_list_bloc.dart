import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  final AccountsRepository _accountsRepository;

  AccountListBloc(
    this._accountsRepository,
  ) : super(AccountListState.initial()) {
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
  }
}

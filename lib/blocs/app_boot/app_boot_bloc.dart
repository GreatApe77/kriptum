import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';

part 'app_boot_event.dart';
part 'app_boot_state.dart';

class AppBootBloc extends Bloc<AppBootEvent, AppBootState> {
  final AccountsRepository _accountsRepository;
  AppBootBloc({required AccountsRepository accountsRepository})
      : _accountsRepository = accountsRepository,
        super(
          AppBootState(
            appBootStatus: AppBootStatus.unknown,
          ),
        ) {
    on<AppBootStarted>(
      (event, emit) async {
        final accounts = await _accountsRepository.getAccounts();
        if (accounts.isEmpty) {
          emit(
            AppBootState(appBootStatus: AppBootStatus.noWallet),
          );
        } else {
          emit(
            AppBootState(appBootStatus: AppBootStatus.lockedWallet),
          );
        }
      },
    );
  }
}

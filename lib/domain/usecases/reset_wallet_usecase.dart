import 'package:kriptum/domain/repositories/accounts_repository.dart';

class ResetWalletUsecase {
  final AccountsRepository _accountsRepository;
  ResetWalletUsecase({
    required AccountsRepository accountsRepository,
  }) : _accountsRepository = accountsRepository;

  Future<void> execute() async {
    await _accountsRepository.deleteAllAccounts();
  }
}

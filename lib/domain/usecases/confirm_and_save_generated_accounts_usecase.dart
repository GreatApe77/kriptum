import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';

class ConfirmAndSaveGeneratedAccountsUsecase {
  final AccountsRepository _accountsRepository;
  ConfirmAndSaveGeneratedAccountsUsecase({
    required AccountsRepository accountsRepository,
  }) : _accountsRepository = accountsRepository;

  Future<void> execute(List<Account> accounts) async {
    await _accountsRepository.saveAccounts(accounts);
  }
}

import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';

class LockWalletUsecase {
  final AccountsRepository _accountsRepository;
  final PasswordRepository _passwordRepository;

  LockWalletUsecase(this._accountsRepository, this._passwordRepository);

  Future<void> execute() async {
    _passwordRepository.setPassword('');
    await _accountsRepository.changeCurrentAccount(null);
  }
}

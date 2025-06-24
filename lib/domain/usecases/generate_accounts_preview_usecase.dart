import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';

class GenerateAccountsPreviewUsecase {
  final AccountGeneratorService _accountGenerator;
  final PasswordRepository _passwordRepository;
  GenerateAccountsPreviewUsecase(
      {required AccountGeneratorService accountGenerator,
      required PasswordRepository passwordRepository})
      : _accountGenerator = accountGenerator,
        _passwordRepository = passwordRepository;

  Future<List<Account>> execute(
    GenerateAccountsPreviewUsecaseParams params,
  ) async {
    final accounts = await _accountGenerator.generateAccounts(
      AccountsFromMnemonicParams(
        mnemonic: params.mnemonic,
        encryptionPassword: params.password,
        amount: 3,
      ),
    );
    _passwordRepository.setPassword(params.password);
    return accounts;
    //await _accountsRepository.saveAccounts(accounts);
  }
}

class GenerateAccountsPreviewUsecaseParams {
  final String password;
  final String mnemonic;

  GenerateAccountsPreviewUsecaseParams({
    required this.password,
    required this.mnemonic,
  });
}

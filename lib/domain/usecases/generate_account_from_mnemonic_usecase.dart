import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';

class GenerateAccountFromMnemonicUsecase {
  final AccountGeneratorService _accountGenerator;
  final AccountsRepository _accountsRepository;

  GenerateAccountFromMnemonicUsecase({
    required AccountGeneratorService accountGenerator,
    required AccountsRepository accountsRepository,
  })  : _accountGenerator = accountGenerator,
        _accountsRepository = accountsRepository;

  Future<void> execute(
    GenerateAccountFromMnemonicUsecaseParams params,
  ) async {
    final accounts = await _accountGenerator.generateAccounts(
      AccountsFromMnemonicParams(
        mnemonic: params.mnemonic,
        encryptionPassword: params.password,
        amount: 20,
      ),
    );
    await _accountsRepository.saveAccounts(accounts);
  }
}

class GenerateAccountFromMnemonicUsecaseParams {
  final String password;
  final String mnemonic;

  GenerateAccountFromMnemonicUsecaseParams({
    required this.password,
    required this.mnemonic,
  });
}

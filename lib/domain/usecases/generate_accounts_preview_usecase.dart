import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';

class GenerateAccountsPreviewUsecase {
  final AccountGeneratorService _accountGenerator;

  GenerateAccountsPreviewUsecase({
    required AccountGeneratorService accountGenerator,
  })  : _accountGenerator = accountGenerator;
        

  Future<List<Account>> execute(
    GenerateAccountsPreviewUsecaseParams params,
  ) async {
    final accounts = await _accountGenerator.generateAccounts(
      AccountsFromMnemonicParams(
        mnemonic: params.mnemonic,
        encryptionPassword: params.password,
        amount: 20,
      ),
    );
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

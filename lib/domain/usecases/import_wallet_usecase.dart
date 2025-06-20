import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';

class ImportWalletUsecase {
  final AccountGeneratorService _accountGeneratorService;
  final AccountsRepository _accountsRepository;

  ImportWalletUsecase(this._accountGeneratorService, this._accountsRepository);
  Future<void> execute(ImportWalletUsecaseParams params) async {
    final accounts = await _accountGeneratorService.generateAccounts(
      AccountsFromMnemonicParams(
        mnemonic: params.mnemonic,
        encryptionPassword: params.encryptionPassword,
        amount: params.amount,
      ),
    );
    await _accountsRepository.saveAccounts(accounts);
  }
}

class ImportWalletUsecaseParams {
  final String mnemonic;
  final String encryptionPassword;
  final int amount;

  ImportWalletUsecaseParams({
    required this.mnemonic,
    required this.encryptionPassword,
    this.amount = 20,
  });
}

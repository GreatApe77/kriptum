import 'package:kriptum/domain/factories/mnemonic_factory.dart';
import 'package:kriptum/domain/models/mnemonic.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';

class ImportWalletUsecase {
  final AccountGeneratorService _accountGeneratorService;
  final AccountsRepository _accountsRepository;
  final MnemonicFactory _mnemonicFactory;
  final PasswordRepository _passwordRepository;
  ImportWalletUsecase(
    this._accountGeneratorService,
    this._accountsRepository,
    this._mnemonicFactory,
    this._passwordRepository
  );
  Future<void> execute(ImportWalletUsecaseParams params) async {
    final result = _mnemonicFactory.create(params.mnemonic);
    if (result.isFailure) {
      throw Exception(result.failure);
    }
    final validatedMnemonic = result.value!.phrase;
    final accounts = await _accountGeneratorService.generateAccounts(
      AccountsFromMnemonicParams(
        mnemonic: validatedMnemonic,
        encryptionPassword: params.encryptionPassword,
        amount: params.amount,
      ),
    );
    await _accountsRepository.saveAccounts(accounts);
    _passwordRepository.setPassword(params.encryptionPassword);
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

import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/services/account_decryption_with_password_service.dart';

class UnlockWalletUsecase {
  final AccountsRepository _accountsRepository;
  final AccountDecryptionWithPasswordService
      _accountDecryptionWithPasswordService;
  UnlockWalletUsecase({
    required AccountsRepository accountsRepository,
    required AccountDecryptionWithPasswordService
        accountDecryptionWithPasswordService,
  })  : _accountsRepository = accountsRepository,
        _accountDecryptionWithPasswordService =
            accountDecryptionWithPasswordService;
  Future<void> execute(String password) async {
    final account = await _accountsRepository.getCurrentAccount();
    if (account == null) {
      throw Exception('No current account found');
    }
    final gotPasswordRight =
        await _accountDecryptionWithPasswordService.isPasswordCorrect(
      AccountDecryptionWithPasswordParams(
        password: password,
        encryptedAccount: account.encryptedJsonWallet,
      ),
    );
    if (!gotPasswordRight) {
      throw Exception('Wrong password');
    }
  }
}

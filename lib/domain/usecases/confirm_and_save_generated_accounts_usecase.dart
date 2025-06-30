import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/mnemonic_repository.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';
import 'package:kriptum/domain/services/encryption_service.dart';

class ConfirmAndSaveGeneratedAccountsUsecase {
  final AccountsRepository _accountsRepository;
  final EncryptionService _encryptionService;
  final MnemonicRepository _mnemonicRepository;
  final PasswordRepository _passwordRepository;
  ConfirmAndSaveGeneratedAccountsUsecase({
    required AccountsRepository accountsRepository,
    required EncryptionService encryptionService,
    required MnemonicRepository mnemonicRepository,
    required PasswordRepository passwordRepository,
  })  : _accountsRepository = accountsRepository,
        _encryptionService = encryptionService,
        _mnemonicRepository = mnemonicRepository,
        _passwordRepository = passwordRepository;

  Future<void> execute(List<Account> accounts, String mnemonic) async {
    final password = _passwordRepository.getPassword();
    final encryptedMnemonic = _encryptionService.encrypt(data: mnemonic, password: password);
    await _accountsRepository.saveAccounts(accounts);
    await _mnemonicRepository.storeEncryptedMnemonic(encryptedMnemonic);
  }
}

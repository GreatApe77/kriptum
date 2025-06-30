import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';
import 'package:kriptum/domain/repositories/mnemonic_repository.dart';

class ResetWalletUsecase {
  final AccountsRepository _accountsRepository;
  final MnemonicRepository _mnemonicRepository;
  final ContactsRepository _contactsRepository;
  ResetWalletUsecase({
    required AccountsRepository accountsRepository,
    required MnemonicRepository mnemonicRepository,
    required ContactsRepository contactsRepository,
  })  : _accountsRepository = accountsRepository,
        _mnemonicRepository = mnemonicRepository,
        _contactsRepository = contactsRepository;

  Future<void> execute() async {
    await _accountsRepository.changeCurrentAccount(null);
    await _accountsRepository.deleteAllAccounts();
    await _mnemonicRepository.storeEncryptedMnemonic('');
    await _contactsRepository.deleteAllContacts();
  }
}

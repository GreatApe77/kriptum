import 'package:flutter/foundation.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/encryption_service.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';

class CreateNewWalletController extends ChangeNotifier {
  String _generatedMnemonic = '';
  Account? _createdAccount;
  List<Account> _createdAccounts = [];
  bool _loading = false;

  final WalletServices _walletServices;
  final AccountRepository _accountRepository;
  final EncryptionService _encryptionService;
  CreateNewWalletController(
      {required EncryptionService encryptionService,
      required WalletServices walletServices,
      required AccountRepository accountRepository})
      : _walletServices = walletServices,
        _accountRepository = accountRepository,
        _encryptionService = encryptionService;
  String get generatedMnemonic => _generatedMnemonic;
  bool get loading => _loading;
  Future<void> saveAccount() async {
    await _accountRepository.saveAccount(_createdAccount!);
  }

  Future<void> saveAccounts({
    required Function() onSuccess,
    required Function() onFail,
  }) async {
    try {
      await _accountRepository.saveAccounts(_createdAccounts);
      await onSuccess();
    } catch (e) {
      await onFail();
    }
  }

  Future<void> createNewWalletWithAccounts({
    required String password,
    required SettingsController settingsController,
    required Function() onSuccess,
    required Function() onFail,
  }) async {
    try {
      _loading = true;
      notifyListeners();
      _generatedMnemonic = _walletServices.generateMnemonic();
      _createdAccounts = await compute(
          WalletServices.generateAccountsFromMnemonic,
          AccountsFromMnemonicParams(
              mnemonic: _generatedMnemonic,
              encryptionPassword: password,
              amount: 1));

      String encryptedMnemonic =
          _encryptionService.encrypt(password, _generatedMnemonic);
      await settingsController.setEncryptedMnemonic(encryptedMnemonic);
      await onSuccess();
    } catch (e) {
      await onFail();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> createNewWallet(String password) async {
    //pegar mnemonico gerado
    //gerar os pares (private,pub)
    // encriptar todas as contas com a mesma senha

    _loading = true;
    notifyListeners();
    _generatedMnemonic = _walletServices.generateMnemonic();

    //Account account = await WalletServices.getAccountFromMnemonic(
    //    AccountFromMnemonicParams(

    //        mnemonic: _generatedMnemonic, encryptionPassword: password));

    _createdAccount = await compute(
        WalletServices.getAccountFromMnemonic,
        AccountFromMnemonicParams(
            mnemonic: _generatedMnemonic, encryptionPassword: password));
    //await _accountRepository.saveAccount(account);

    _loading = false;
    notifyListeners();
  }
}

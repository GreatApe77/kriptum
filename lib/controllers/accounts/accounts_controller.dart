import 'package:flutter/foundation.dart';

import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/encryption_service.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';

class AccountsController extends ChangeNotifier {
  bool importLoading = false;
  bool addAccountLoading = false;
  List<Account> _accounts = [];
  final AccountRepository _accountRepository;
  final WalletServices _walletServices;
  final EncryptionService _encryptionService;

  List<Account> get accounts => _accounts;
  //int accountIndex = 0;
  AccountsController(
      {required AccountRepository accountRepository,
      required EncryptionService encryptionService,
      required WalletServices walletServices})
      : _accountRepository = accountRepository,
        _walletServices = walletServices,
        _encryptionService = encryptionService;

  void loadAccounts() async {
    _accounts = await _accountRepository.getAccounts();
    notifyListeners();
  }

  Future<void> updateAccount(int index, Account account) async {
    _accounts[index] = account;
    await _accountRepository.updateAccount(account.accountIndex, account);
    notifyListeners();
  }

  Future<void> addAccount(String password, String encryptedMnemonic,
      {required int hdWalletAccountIndex,
      required Function(String accountAddress) onSuccess,
      required Function() onFail}) async {
    try {
      addAccountLoading = true;
      notifyListeners();
      String decryptedMnemonic =
          _encryptionService.decrypt(password, encryptedMnemonic);

      final Account generatedAccount = await compute(
          WalletServices.getAccountFromMnemonic,
          AccountFromMnemonicParams(
              mnemonic: decryptedMnemonic,
              encryptionPassword: password,
              index: hdWalletAccountIndex));
      await _accountRepository.saveAccount(generatedAccount);
      _accounts.add(generatedAccount);

      await onSuccess(generatedAccount.address);
    } catch (e) {
      onFail();
    } finally {
      addAccountLoading = false;
      notifyListeners();
    }
  }

  // Future<void> addAccount(String password) async {
  //   Account account = await WalletServices.
  // }
  Future<void> importAccountFromPrivateKey(
      {required String privateKey,
      required String password,
      required Function() onSuccess,
      required Function() onFail,
      required Function() onAlreadyExistingAccount}) async {
    // Account importedAccount = await WalletServices.importAccountFromPrivateKey(
    //     ImportAccountParams(_accounts.length,
    //         privateKey: privateKey, password: password));

    try {
      importLoading = true;
      notifyListeners();

      Account importedAccount = await compute(
          WalletServices.importAccountFromPrivateKey,
          ImportAccountParams(_accounts.length,
              privateKey: privateKey, password: password));
      final index = _accounts.indexWhere(
        (element) => element.address == importedAccount.address,
      );
      if (index != -1) {
      } else {
        await _accountRepository.saveAccount(importedAccount);
        _accounts.add(importedAccount);
        onSuccess();
      }
    } catch (e) {
      onFail();
    } finally {
      importLoading = false;
      notifyListeners();
    }
  }
}

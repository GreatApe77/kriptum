import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hd_wallet_kit/hd_wallet_kit.dart';

import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';

class AccountsController extends ChangeNotifier {
  bool importLoading = false;

  List<Account> _accounts = [];
  final AccountRepository _accountRepository;
  final WalletServices _walletServices;

  List<Account> get accounts => _accounts;
  //int accountIndex = 0;
  AccountsController(
      {required AccountRepository accountRepository,
      required WalletServices walletServices})
      : _accountRepository = accountRepository,
        _walletServices = walletServices;

  void loadAccounts() async {
    _accounts = await _accountRepository.getAccounts();
    notifyListeners();
  }

  Future<void> updateAccount(int index, Account account) async {
    _accounts[index] = account;
    await _accountRepository.updateAccount(account.accountIndex, account);
    notifyListeners();
  }

  // Future<void> addAccount(String password) async {
  //   Account account = await WalletServices.
  // }
  Future<void> importAccountFromPrivateKey(
      {required String privateKey,
      required String password,
      required Function() onSuccess,
      required Function() onFail}) async {
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
      await _accountRepository.saveAccount(importedAccount);
      _accounts.add(importedAccount);
      onSuccess();
    } catch (e) {
      onFail();
    } finally {
      importLoading = false;
      notifyListeners();
    }
  }
}

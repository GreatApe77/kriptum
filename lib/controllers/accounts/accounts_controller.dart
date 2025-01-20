import 'package:flutter/material.dart';

import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';

class AccountsController extends ChangeNotifier {
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

  Future<void> addAccount(String password) async {
    //TODO
  }
  //Future<void> importAccountFromPrivateKey(String privateKey) {}
}

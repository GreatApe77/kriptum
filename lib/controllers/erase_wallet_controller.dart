import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';

class EraseWalletController extends ChangeNotifier {
  bool isLoading = false;
  final AccountRepository _accountRepository;

  EraseWalletController({required AccountRepository accountRepository})
      : _accountRepository = accountRepository;


  eraseWallet()async {
    isLoading=true;
    notifyListeners();

    await _accountRepository.clearAccounts();
    isLoading = false;
    notifyListeners();

  }
}

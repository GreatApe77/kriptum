import 'package:flutter/material.dart';
import 'package:kriptum/data/services/wallet_services.dart';

class AccountBalanceController extends ChangeNotifier {
  //bool isLoading = false;
  BigInt balance = BigInt.from(0);
  final WalletServices _walletServices;

  AccountBalanceController({required WalletServices walletServices})
      : _walletServices = walletServices;

  loadAccountBalance(String accountAddress) async {
    balance = await _walletServices.getBalance(accountAddress);
    notifyListeners();
  }
}

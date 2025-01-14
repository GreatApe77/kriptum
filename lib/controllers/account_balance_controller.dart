import 'package:flutter/material.dart';
import 'package:kriptum/data/services/wallet_services.dart';

class AccountBalanceController extends ChangeNotifier {
  bool isLoading = false;
  BigInt balance = BigInt.from(0);
  final WalletServices _walletServices;

  AccountBalanceController({required WalletServices walletServices})
      : _walletServices = walletServices;

  loadAccountBalance(String accountAddress, {String? rpcEndpoint}) async {
    isLoading = true;
    notifyListeners();
    balance = await _walletServices.getBalance(accountAddress,
        rpcEndpoint: rpcEndpoint ?? 'http://10.0.2.2:8545');
    isLoading = false;
    notifyListeners();
  }
}

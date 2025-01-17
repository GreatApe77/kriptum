import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/network.dart';

class SendTransactionController extends ChangeNotifier {
  bool isLoading = false;
  bool failed = false;
  String txHashResult = '';
  Future<void> sendTransaction({
    required Account connectedAccount,
    required Network connectedNetwork,
    required String password,
    required String to,
    required BigInt amountInWei,
    required Function() onSuccess,
    required Function() onFail,
  }) async {
    try {
      failed = false;
      isLoading = true;
      notifyListeners();

      final txHash = await WalletServices.sendTransaction(
          encryptedJsonAccount: connectedAccount.encryptedJsonWallet,
          password: password,
          to: to,
          amountInWei: amountInWei,
          network: connectedNetwork);
      txHashResult = txHash;
      onSuccess();
    } catch (e) {
      failed = true;
      onFail();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

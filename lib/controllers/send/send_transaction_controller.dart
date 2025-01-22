import 'package:flutter/foundation.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/shared/utils/memory_cache.dart';

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
    required Function(
      String transactionHash
    ) onSuccess,
    required Function() onFail,
  }) async {
    try {
      failed = false;
      isLoading = true;
      notifyListeners();

      final txHash = await compute(
          WalletServices.sendTransaction,
          (SendTransactionParams(
              encryptedJsonAccount: connectedAccount.encryptedJsonWallet,
              password: password,
              to: to,
              amountInWei: amountInWei,
              network: connectedNetwork)));
      txHashResult = txHash;
      onSuccess(txHash);
      MemoryCache.clearCache();
    } catch (e) {
      //print(e.toString());
      failed = true;
      onFail();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

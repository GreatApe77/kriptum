import 'package:flutter/material.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/shared/utils/memory_cache.dart';
import 'package:kriptum/shared/utils/memory_cache_key_builders.dart';

class AccountBalanceController extends ChangeNotifier {
  
  bool failed = false;
  bool isLoading = false;
  BigInt balance = BigInt.from(0);
  final WalletServices _walletServices;

  AccountBalanceController({required WalletServices walletServices})
      : _walletServices = walletServices;

  loadAccountBalance(String accountAddress, Network network) async {
    try {
      isLoading = true;
      failed =false;
      notifyListeners();
      String key = MemoryCacheKeyBuilders.buildKeyForAccountBalanceCache(
          accountAddress: accountAddress, networkId: network.id!.toString());
      BigInt? retrievedBalance = MemoryCache.get<BigInt>(key);

      if (retrievedBalance == null) {
        retrievedBalance = await _walletServices.getBalance(accountAddress,
            rpcEndpoint: network.rpcUrl);
        MemoryCache.store<BigInt>(key, retrievedBalance,
            duration: const Duration(seconds: 120));
      }
      balance = retrievedBalance;
      //balance = await _walletServices.getBalance(accountAddress,
      //    rpcEndpoint: network.rpcUrl);
    } catch (e) {
      failed = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

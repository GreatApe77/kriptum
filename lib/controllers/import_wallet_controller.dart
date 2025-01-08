import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/wallet_services.dart';

class ImportWalletController extends ChangeNotifier {
  bool loading = false;
  late final AccountRepository accountRepository;
  Future<void> importWallet(
      {required String mnemonic, required String password}) async {
    loading = true;
    notifyListeners();
    final account = await compute(
        WalletServices.getAccountFromMnemonic,
        AccountFromMnemonicParams(
            mnemonic: mnemonic, encryptionPassword: password));

    await accountRepository.saveAccount(account);
    loading = false;
    notifyListeners();
  }
}

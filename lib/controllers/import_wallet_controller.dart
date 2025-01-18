import 'package:flutter/foundation.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/wallet_services.dart';

class ImportWalletController extends ChangeNotifier {
  bool loading = false;
  final AccountRepository accountRepository;

  ImportWalletController({required this.accountRepository});
  Future<void> importWalletWithMultipleAccounts({
    required String mnemonic,
    required String password,
    required Function() onError,
    required Function() onSuccess,
  }) async {
    try {
      loading = true;
      notifyListeners();

      final accounts = await compute(
          WalletServices.generateAccountsFromMnemonic,
          AccountsFromMnemonicParams(
              mnemonic: mnemonic, encryptionPassword: password));
      await accountRepository.saveAccounts(accounts);
       onSuccess();
    } catch (e) {
      loading = false;
      notifyListeners();
      onError();
    }
  }

  Future<void> importWallet(
      {required String mnemonic, required String password}) async {
    loading = true;
    notifyListeners();
    try {
      final account = await compute(
          WalletServices.getAccountFromMnemonic,
          AccountFromMnemonicParams(
              mnemonic: mnemonic, encryptionPassword: password));

      await accountRepository.saveAccount(account);
    } catch (e) {
      // print('DEU ERRO AQUI');
      // print(e.toString());
    }
    loading = false;
    notifyListeners();
  }
}

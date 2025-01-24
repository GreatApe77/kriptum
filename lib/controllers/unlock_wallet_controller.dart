import 'package:flutter/foundation.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/wallet_services.dart';

class UnlockWalletController extends ChangeNotifier {
  bool isLoading = false;
  final AccountRepository _accountsRepository;

  UnlockWalletController(
      {required AccountRepository accountsRepository,
      required WalletServices walletServices})
      : _accountsRepository = accountsRepository;

  unlockWallet({
    required String password,
    required int accountIndex,
    required Function() onWrongPassword,
    required Function() onSuccess,
  }) async {
    isLoading = true;
    notifyListeners();
    final account = await _accountsRepository.getAccount(accountIndex);
    //bool rightPassword = WalletServices.verifyPasswordForEncryptedAccount(
    //    DecryptAccountWithPasswordParams(
    //        password: password,
    //        encryptedJsonAccount: account.encryptedJsonWallet));
//

    final rightPassword = await compute(
        WalletServices.verifyPasswordForEncryptedAccount,
        DecryptAccountWithPasswordParams(
            password: password,
            encryptedJsonAccount: account.encryptedJsonWallet));
    isLoading = false;
    
    if (rightPassword) {
      await onSuccess();
    } else {
      await onWrongPassword();
    }
    notifyListeners();
  }
}

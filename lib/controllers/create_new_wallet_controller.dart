import 'package:flutter/foundation.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';

class CreateNewWalletController extends ChangeNotifier {
  String _generatedMnemonic = '';
  Account? _createdAccount;
  List<Account> _createdAccounts = [];
  bool _loading = false;

  final WalletServices _walletServices;
  final AccountRepository _accountRepository;
  CreateNewWalletController(
      {required WalletServices walletServices,
      required AccountRepository accountRepository})
      : _walletServices = walletServices,
        _accountRepository = accountRepository;
  String get generatedMnemonic => _generatedMnemonic;
  bool get loading => _loading;
  Future<void> saveAccount() async {
    await _accountRepository.saveAccount(_createdAccount!);
  }
  Future<void> saveAccounts() async {
    await _accountRepository.saveAccounts(_createdAccounts);
  }

  Future<void> createNewWalletWithAccounts(String password) async {
    _loading = true;
    notifyListeners();
    _generatedMnemonic = _walletServices.generateMnemonic();
    _createdAccounts = await compute(
        WalletServices.generateAccountsFromMnemonic,
        AccountsFromMnemonicParams(
            mnemonic: _generatedMnemonic, encryptionPassword: password));
    _loading = false;
    notifyListeners();
  }

  Future<void> createNewWallet(String password) async {
    //pegar mnemonico gerado
    //gerar os pares (private,pub)
    // encriptar todas as contas com a mesma senha

    _loading = true;
    notifyListeners();
    _generatedMnemonic = _walletServices.generateMnemonic();

    //Account account = await WalletServices.getAccountFromMnemonic(
    //    AccountFromMnemonicParams(

    //        mnemonic: _generatedMnemonic, encryptionPassword: password));

    _createdAccount = await compute(
        WalletServices.getAccountFromMnemonic,
        AccountFromMnemonicParams(
            mnemonic: _generatedMnemonic, encryptionPassword: password));
    //await _accountRepository.saveAccount(account);

    _loading = false;
    notifyListeners();
  }
}

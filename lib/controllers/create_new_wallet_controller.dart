import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/domain/models/account.dart';

class CreateNewWalletController extends ChangeNotifier {
  String _generatedMnemonic = '';
  final WalletServices _walletServices;
  final AccountRepository _accountRepository;
  CreateNewWalletController(
      {required WalletServices walletServices,
      required AccountRepository accountRepository})
      : _walletServices = walletServices,
        _accountRepository = accountRepository;
  String get generatedMnemonic => _generatedMnemonic;

  Future<void> createNewWallet(String password) async {
    //pegar mnemonico gerado
    //gerar os pares (private,pub)
    // encriptar todas as contas com a mesma senha

    _generatedMnemonic = _walletServices.generateMnemonic();
    notifyListeners();
    Account account = await _walletServices.getAccountFromMnemonic(
        mnemonic: _generatedMnemonic, encryptionPassword: password);
    await _accountRepository.saveAccount(account);
    
  }
}

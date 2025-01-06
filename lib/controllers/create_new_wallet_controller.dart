import 'package:flutter/material.dart';
import 'package:kriptum/data/services/wallet_services.dart';

class CreateNewWalletController extends ChangeNotifier {
  String _generatedMnemonic = '';
  final WalletServices _walletServices;
  CreateNewWalletController({required WalletServices walletServices})
      : _walletServices = walletServices;
  String get generatedMnemonic => _generatedMnemonic;

  void createNewWallet(String password) {
    //pegar mnemonico gerado
    //gerar os pares (private,pub)
    // encriptar todas as contas com a mesma senha

    _generatedMnemonic = _walletServices.generateMnemonic();
    notifyListeners();
  }
}

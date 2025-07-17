import 'package:kriptum/domain/models/account.dart';

abstract interface class AccountGeneratorService {
  String generateMnemonic();
  Future<List<Account>> generateAccounts(AccountsFromMnemonicParams params);
  Future<Account> generateSingleAccount(SingleAccountFromMnemonicParams params);
  Future<Account> generateAccountFromPrivateKey({required String encryptionPassword, required String privateKey});
}

class AccountsFromMnemonicParams {
  final String mnemonic;
  final String encryptionPassword;
  final int amount;

  AccountsFromMnemonicParams({
    required this.mnemonic,
    required this.encryptionPassword,
    this.amount = 20,
  });
}

class SingleAccountFromMnemonicParams {
  final String mnemonic;
  final String encryptionPassword;
  final int hdIndex;

  SingleAccountFromMnemonicParams({
    required this.mnemonic,
    required this.encryptionPassword,
    required this.hdIndex,
  });
}

import 'package:kriptum/domain/models/account.dart';

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

abstract interface class AccountGeneratorService {
  String generateMnemonic();
  Future<List<Account>> generateAccounts(AccountsFromMnemonicParams params);
}

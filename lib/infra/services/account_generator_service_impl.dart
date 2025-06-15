import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hd_wallet_kit/hd_wallet_kit.dart';
import 'package:hex/hex.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';

class AccountGeneratorServiceImpl implements AccountGeneratorService {
  @override
  Future<List<Account>> generateAccounts(
    AccountsFromMnemonicParams params,
  ) async {
    final accounts = <Account>[];
    final seed = bip39.mnemonicToSeed(params.mnemonic);
    final hdWallet = HDWallet.fromSeed(seed: seed);

    for (int i = 0; i < params.amount; i++) {
      final key = hdWallet.deriveKey(
        purpose: Purpose.BIP44,
        coinType: 60, // Ethereum
        account: 0,
        change: 0,
        index: i,
      );

      final privateKeyHex = HEX.encode(key.privKeyBytes!);
      final ethPrivateKey = EthPrivateKey.fromHex(privateKeyHex);
      final address = ethPrivateKey.address.hex;

      final encryptedJson = Wallet.createNew(
        ethPrivateKey,
        params.encryptionPassword,
        Random.secure(),
      ).toJson();

      accounts.add(
        Account(
          accountIndex: i,
          alias: 'Account ${i + 1}',
          address: address,
          encryptedJsonWallet: encryptedJson,
        ),
      );
    }

    return accounts;
  }

  @override
  String generateMnemonic() {
    return Mnemonic.generate().join(' ');
  }
}

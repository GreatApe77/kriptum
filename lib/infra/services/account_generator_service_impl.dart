import 'dart:math';
import 'package:flutter/foundation.dart';
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
    final accounts = await compute(_heavyComputingAccountGeneration, params);
    return accounts;
  }

  @override
  String generateMnemonic() {
    return Mnemonic.generate().join(' ');
  }

  @override
  Future<Account> generateSingleAccount(
    SingleAccountFromMnemonicParams params,
  ) async {
    final account = await compute(_heavyComputingSingleAccountGeneration, params);
    return account;
  }
}

Future<Account> _heavyComputingSingleAccountGeneration(SingleAccountFromMnemonicParams params) {
  final seed = bip39.mnemonicToSeed(params.mnemonic);
  final hdWallet = HDWallet.fromSeed(seed: seed);
  final key = hdWallet.deriveKey(
    purpose: Purpose.BIP44,
    coinType: 60, // Ethereum coin type
    account: 0,
    change: 0,
    index: params.hdIndex,
  );
  final ethPrivateKey = EthPrivateKey.fromHex(HEX.encode(key.privKeyBytes!));
  final address = ethPrivateKey.address.hex;
  final String encryptedAccount = Wallet.createNew(ethPrivateKey, params.encryptionPassword, Random.secure()).toJson();
  Account account = Account(
    alias: 'Account ${params.hdIndex + 1}',
    address: address,
    encryptedJsonWallet: encryptedAccount,
    accountIndex: params.hdIndex,
  );
  return Future.value(account);
}

Future<List<Account>> _heavyComputingAccountGeneration(
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

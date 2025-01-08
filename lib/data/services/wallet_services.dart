// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:hd_wallet_kit/hd_wallet_kit.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'package:kriptum/domain/models/account.dart';

class AccountFromMnemonicParams {
  final String mnemonic;
  final String encryptionPassword;
  int index;
  AccountFromMnemonicParams({
    required this.mnemonic,
    required this.encryptionPassword,
    this.index = 0,
  });
}

class DecryptAccountWithPasswordParams {
  final String password;
  final String encryptedJsonAccount;

  DecryptAccountWithPasswordParams(
      {required this.password, required this.encryptedJsonAccount});
}

class WalletServices {
  // // Generate a mnemonic phrase
  String generateMnemonic() {
    return Mnemonic.generate().join(' ');
  }

  static bool verifyPasswordForEncryptedAccount(
      DecryptAccountWithPasswordParams decryptingParams) {
    try {
      Wallet.fromJson(
          decryptingParams.encryptedJsonAccount, decryptingParams.password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Account> getAccountFromMnemonic(
      AccountFromMnemonicParams params) {
    if (!bip39.validateMnemonic(params.mnemonic)) {
      throw ArgumentError('Invalid mnemonic phrase');
    }
    final seed = bip39.mnemonicToSeed(params.mnemonic);
    final hdWallet = HDWallet.fromSeed(seed: seed);
    final key = hdWallet.deriveKey(
      purpose: Purpose.BIP44,
      coinType: 60, // Ethereum coin type
      account: 0,
      change: 0,
      index: params.index,
    );
    final ethPrivateKey = EthPrivateKey.fromHex(HEX.encode(key.privKeyBytes!));
    final address = ethPrivateKey.address.hex;
    final String encryptedAccount = Wallet.createNew(
            ethPrivateKey, params.encryptionPassword, Random.secure())
        .toJson();
    Account account = Account(
        address: address,
        encryptedJsonWallet: encryptedAccount,
        accountIndex: params.index);
    return Future.value(account);
  }
  // // Generate the private key for a specific derivation path
  // Future<String> getPrivateKey(String mnemonic, {int index = 0}) async {
  //   final seed = bip39.mnemonicToSeed(mnemonic);
  //   final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);

  //   // Derive the key using the BIP-44 path for Ethereum
  //   final childKey = await ED25519_HD_KEY.derivePath(
  //     "m/44'/60'/0'/0/$index",
  //     seed,
  //   );

  //   return HEX.encode(childKey.key);
  // }

  // // Generate an Ethereum address for a specific index
  // Future<String> getAddress(String mnemonic, {int index = 0}) async {
  //   // Get the private key for the given index
  //   String privateKey = await getPrivateKey(mnemonic, index: index);

  //   // Generate the public key and address
  //   EthPrivateKey ethPrivateKey = EthPrivateKey.fromHex(privateKey);
  //   EthereumAddress address = await ethPrivateKey.extractAddress();

  //   return address.hex;
  // }

  // // Generate multiple addresses
  // Future<List<String>> generateAddresses(String mnemonic, int count) async {
  //   List<String> addresses = [];
  //   for (int i = 0; i < count; i++) {
  //     String address = await getAddress(mnemonic, index: i);
  //     addresses.add(address);
  //   }
  //   return addresses;
  // }
  // Generate Ethereum addresses from a mnemonic
  Future<List<String>> deriveAddresses(String mnemonic, int count) async {
    if (!bip39.validateMnemonic(mnemonic)) {
      throw ArgumentError('Invalid mnemonic phrase');
    }

    // Convert mnemonic to seed
    final seed = bip39.mnemonicToSeed(mnemonic);
    //Wallet.fromJson(encoded, password)
    // Initialize the HD wallet
    final hdWallet = HDWallet.fromSeed(seed: seed);

    List<String> addresses = [];
    for (int i = 0; i < count; i++) {
      // Derive the key for the given index
      final key = hdWallet.deriveKey(
        purpose: Purpose.BIP44,
        coinType: 60, // Ethereum coin type
        account: 0,
        change: 0,
        index: i,
      );
      // Generate the Ethereum address
      final ethPrivateKey =
          EthPrivateKey.fromHex(HEX.encode(key.privKeyBytes!));
      final wallet =
          Wallet.createNew(ethPrivateKey, 'some_password', Random.secure());
      wallet.toJson();
      final address = ethPrivateKey.address;

      addresses.add(address.hex);
    }

    return addresses;
  }
}

void main(List<String> args) async {
  final myEthAddress = "0x8274Cf5D8bFE3f5cb246bd8fA80dB31D544C5f30";
  final ganacheAddress = "0xAa790f8885B45d9bd427DCB9B0fcEbCaF7a77Ec4";

  final ethRpcEndpoint = 'http://127.0.0.1:8545';
  final httpClient = Client();
  final ethClient = Web3Client(ethRpcEndpoint, httpClient);

  final balance =
      await ethClient.getBalance(EthereumAddress.fromHex(ganacheAddress));
  print('BALANCE BEFORE: ${balance.getValueInUnit(EtherUnit.ether)}');
  final result = await ethClient.sendTransaction(
    EthPrivateKey.fromHex(
        '0x7b4c95ceb78227b95e1fdea9d52411b22439af3823b914637eb23d4ec512f192'),
    Transaction(
      to: EthereumAddress.fromHex(myEthAddress),
      //gasPrice: EtherAmount.inWei(BigInt.one),

      value: EtherAmount.fromInt(EtherUnit.finney, 2500),
    ),
  );
  print('TRANSACTION HASH: ${result}');
  final senderBalanceAfter =
      await ethClient.getBalance(EthereumAddress.fromHex(ganacheAddress));
  print(
      'SENDER BALANCE AFTER: ${senderBalanceAfter.getValueInUnit(EtherUnit.ether)}');

  final receiverBalanceAfter =
      await ethClient.getBalance(EthereumAddress.fromHex(myEthAddress));
  print(
      'RECEIVER BALANCE AFTER: ${receiverBalanceAfter.getValueInUnit(EtherUnit.ether)}');  
}

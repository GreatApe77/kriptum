import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;

import 'package:hd_wallet_kit/hd_wallet_kit.dart';
import 'package:hex/hex.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:web3dart/web3dart.dart';

class WalletServices {
  // // Generate a mnemonic phrase
  String generateMnemonic() {
    return Mnemonic.generate().join(' ');
  }

  Future<Account> getAccountFromMnemonic(
      {required String mnemonic,
      required String encryptionPassword,
      int index = 0}) {
    if (!bip39.validateMnemonic(mnemonic)) {
      throw ArgumentError('Invalid mnemonic phrase');
    }
    final seed = bip39.mnemonicToSeed(mnemonic);
    final hdWallet = HDWallet.fromSeed(seed: seed);
    final key = hdWallet.deriveKey(
      
      purpose: Purpose.BIP44,
      coinType: 60, // Ethereum coin type
      account: 0,
      change: 0,
      index: index,
    );
    final ethPrivateKey =
          EthPrivateKey.fromHex(HEX.encode(key.privKeyBytes!));
    final address = ethPrivateKey.address.hex;
    final String encryptedAccount = Wallet.createNew(ethPrivateKey, encryptionPassword, Random.secure()).toJson();
    Account account = Account(address: address, encryptedJsonWallet: encryptedAccount);
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
   final service = WalletServices();
   final words = service.generateMnemonic();
   print(words);
   final account =await  service.getAccountFromMnemonic(mnemonic: words, encryptionPassword: 'encryptionPassword');
   print('==============CONTA=============');
   print(account);
  // print(service.generateMnemonic());
  // final seed = Mnemonic.toSeed(mnemonic.split(' '));
  // final wallet = HDWallet.fromSeed(seed: seed);
  // final HDKey account0 = wallet.deriveKeyByPath(path: "m/44'/0'/0'");
  // print(HEX.encode(account0.pubKey));
  // final address0Key = wallet.deriveKey(
  //     purpose: Purpose.BIP44, coinType: 0, account: 0, change: 0, index: 0);
  // print(HEX.encode(address0Key.pubKeyHash));
  // final ethPrivateKey = EthPrivateKey.fromHex(HEX.encode(address0Key.pubKey));
  // print(ethPrivateKey.address);
  // final service = WalletServices();

  // // Generate a new mnemonic
  // final mnemonic = service.generateMnemonic();
  // //print('Mnemonic: $mnemonic');

  // // Derive and print the addresses
  // final addresses = await service.deriveAddresses(mnemonic, 20);
  // for (var i = 0; i < addresses.length; i++) {
  //   print('Address $i: ${addresses[i]}');
  // }

}

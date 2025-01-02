import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

class WalletServices {
  
  // Generate a mnemonic phrase
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  // Generate the private key for a specific derivation path
  Future<String> getPrivateKey(String mnemonic, {int index = 0}) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    
    // Derive the key using the BIP-44 path for Ethereum
    final childKey = await ED25519_HD_KEY.derivePath(
      "m/44'/60'/0'/0/$index",
      seed,
    );
    
    return HEX.encode(childKey.key);
  }

  // Generate an Ethereum address for a specific index
  Future<String> getAddress(String mnemonic, {int index = 0}) async {
    // Get the private key for the given index
    String privateKey = await getPrivateKey(mnemonic, index: index);

    // Generate the public key and address
    EthPrivateKey ethPrivateKey = EthPrivateKey.fromHex(privateKey);
    EthereumAddress address = await ethPrivateKey.extractAddress();

    return address.hex;
  }

  // Generate multiple addresses
  Future<List<String>> generateAddresses(String mnemonic, int count) async {
    List<String> addresses = [];
    for (int i = 0; i < count; i++) {
      String address = await getAddress(mnemonic, index: i);
      addresses.add(address);
    }
    return addresses;
  }
}
void main(List<String> args) {
  
}
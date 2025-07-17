import 'package:kriptum/domain/factories/ethereum_address/ethereum_address_validator.dart';
import 'package:web3dart/web3dart.dart';

class EthereumAddressValidatorImpl implements EthereumAddressValidator {
  @override
  String? validateWithReason(String ethAddress) {
    try {
      EthereumAddress.fromHex(ethAddress);
      return null;
    } catch (e) {
      return 'Invalid ethereum address';
    }
  }
}

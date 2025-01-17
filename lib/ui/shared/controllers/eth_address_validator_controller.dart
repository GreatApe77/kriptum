import 'package:kriptum/shared/utils/is_valid_ethereum_address.dart';

abstract class EthAddressValidatorController {
  static  String? validateEthAddress(String ethereumAddress){
    if(isValidEthereumAddress(ethereumAddress)) return null;
    return 'Invalid Ethereum Address';
  }
}
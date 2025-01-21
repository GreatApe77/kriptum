import 'package:kriptum/shared/utils/is_valid_private_key.dart';

abstract class PrivateKeyValidatorController {
  static const _message = 'Invalid Private Key';
  static String? validate(String privateKey) {
    if (!isValidEthereumPrivateKey(privateKey)) return _message;
    return null;
  }
}

import 'package:flutter/foundation.dart';
import 'package:kriptum/domain/services/account_decryption_with_password_service.dart';
import 'package:web3dart/web3dart.dart';

class AccountDecryptionWithPasswordServiceImpl
    implements AccountDecryptionWithPasswordService {
  @override
  Future<bool> isPasswordCorrect(
      AccountDecryptionWithPasswordParams params) async {
    final isCorrect = await compute(_isPasswordCorrect, params);
    return isCorrect;
  }
}

Future<bool> _isPasswordCorrect(
  AccountDecryptionWithPasswordParams params,
) async {
  try {
    Wallet.fromJson(
      params.encryptedAccount,
      params.password,
    );
    return true;
  } catch (e) {
    return false;
  }
}

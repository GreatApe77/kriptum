import 'package:kriptum/domain/services/encryption_service.dart';
import 'package:encrypt/encrypt.dart';

class EncryptionServiceImpl implements EncryptionService {
  /// Formats the password to a key length of 32 bytes
  String _formatPassword(String password) {
    if (password.length > 32) {
      throw ArgumentError('password cannot be greater than 32 chars');
    }
    return password.padRight(32, '.').substring(0, 32);
  }

  @override
  String decrypt({required String encryptedData, required String password}) {
    final key = Key.fromUtf8(_formatPassword(password));
    final parts = encryptedData.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid encrypted message format');
    }
    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }

  @override
  String encrypt({required String data, required String password}) {
    final key = Key.fromUtf8(_formatPassword(password));
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(data, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }
}

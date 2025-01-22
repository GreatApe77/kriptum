import 'package:encrypt/encrypt.dart';


class EncryptionService {
  /// Formats the password to a key length of 32 bytes
  String _formatPassword(String password) {
    if(password.length>32) throw ArgumentError('password cannot be greater than 32 chars');
    return password.padRight(32, '.').substring(0, 32);
  }

  /// Encrypts a message with a password
  String encrypt(String password, String message) {
    final key = Key.fromUtf8(_formatPassword(password));
    final iv = IV.fromSecureRandom(16);  // Use a secure random IV
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(message, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  /// Decrypts a message with the correct encryption password
  String decrypt(String password, String encryptedBase64Message) {
    final key = Key.fromUtf8(_formatPassword(password));
    final parts = encryptedBase64Message.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid encrypted message format');
    }
    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}

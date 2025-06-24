abstract interface class EncryptionService {
  String encrypt({
    required String data,
    required String password,
  });

  String decrypt({
    required String encryptedData,
    required String password
  });
}

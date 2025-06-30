abstract interface class MnemonicRepository {
  Future<void> storeEncryptedMnemonic(String encryptedMnemonic);
  Future<String> retrieveEncryptedMnemonic();
}

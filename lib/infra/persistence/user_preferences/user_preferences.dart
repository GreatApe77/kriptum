abstract interface class UserPreferences {
  Future<int> getSelectedAccountId();
  Future<void> setSelectedAccountId(int accountId);
  Future<int> getSelectedNetworkId();
  Future<void> setSelectedNetworkId(int networkId);
  Future<bool> isNativeBalanceVisible();
  Stream<bool> watchNativeBalanceVisibility();
  Future<void> setNativeBalanceVisibility(bool isVisible);
  Future<bool> isDarkModeEnabled();
  Future<void> setDarkModeEnabled(bool isEnabled);
  Future<void> setEncryptedMnemonic(String encryptedMnemonic);
  Future<String> getEncryptedMnemonic();
}

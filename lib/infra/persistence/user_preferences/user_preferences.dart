abstract interface class UserPreferences {
  Future<int> getSelectedAccountId();
  Future<void> setSelectedAccountId(int accountId);
  Future<int> getSelectedNetworkId();
  Future<void> setSelectedNetworkId(int networkId);
}
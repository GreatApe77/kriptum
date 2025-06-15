abstract interface class UserPreferences {
  Future<int> getSelectedAccountId();
  Future<void> setSelectedAccountId(int accountId); 
}
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesImpl implements UserPreferences {
  final SharedPreferences _sh;

  UserPreferencesImpl({
    required SharedPreferences sharedPreferences,
  }) : _sh = sharedPreferences;
  @override
  Future<int> getSelectedAccountId() {
    final accountId = _sh.getInt('selected_account_id');
    if (accountId == null) {
      return Future.value(0); // Default value if not set
    }
    return Future.value(accountId);
  }

  @override
  Future<bool> setSelectedAccountId(int accountId) async {
    return await _sh.setInt('selected_account_id', accountId);
  }

  @override
  Future<int> getSelectedNetworkId() async {
    final networkId = _sh.getInt('selected_network_id');
    if (networkId == null) {
      final defaultId = 4002;
      return defaultId; // Default value if not set
    }
    return networkId;
  }

  @override
  Future<void> setSelectedNetworkId(int networkId) async {
    await _sh.setInt('selected_network_id', networkId);
  }
}

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
}

import 'dart:async';

import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';
import 'package:kriptum/shared/contracts/disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesImpl implements UserPreferences, Disposable {
  final SharedPreferences _sh;
  final StreamController<bool> _visibilityStreamController = StreamController.broadcast();

  UserPreferencesImpl({
    required SharedPreferences sharedPreferences,
  }) : _sh = sharedPreferences;
  @override
  Future<int> getSelectedAccountId() {
    final accountId = _sh.getInt('selected_account_id');
    if (accountId == null) {
      return Future.value(0);
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

  @override
  Future<bool> isDarkModeEnabled() async {
    final isDarkModeEnabled = _sh.getBool('dark_mode_enabled');
    if (isDarkModeEnabled == null) {
      return false;
    }
    return isDarkModeEnabled;
  }

  @override
  Future<bool> isNativeBalanceVisible() async {
    final isVisible = _sh.getBool('native_balance_visible');
    if (isVisible == null) {
      return true;
    }
    return isVisible;
  }

  @override
  Future<void> setDarkModeEnabled(bool isEnabled) async {
    await _sh.setBool('dark_mode_enabled', isEnabled);
  }

  @override
  Future<void> setNativeBalanceVisibility(bool isVisible) async {
    _visibilityStreamController.add(isVisible);
    await _sh.setBool('native_balance_visible', isVisible);
  }

  @override
  Future<String> getEncryptedMnemonic() async {
    final encryptedMnemonyc = _sh.getString('encrypted_mnemonic');
    if (encryptedMnemonyc == null) return '';
    return encryptedMnemonyc;
  }

  @override
  Future<void> setEncryptedMnemonic(String encryptedMnemonic) async {
    await _sh.setString('encrypted_mnemonic', encryptedMnemonic);
  }

  @override
  Stream<bool> watchNativeBalanceVisibility() => _visibilityStreamController.stream;

  @override
  Future<void> dispose() async {
    _visibilityStreamController.close();
  }
}

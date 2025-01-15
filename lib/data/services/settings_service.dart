import 'package:kriptum/data/models/settings.dart';

abstract class SettingsService {
  Future<void> setCurrentAccountIndex(int currentAccountIndex);
  Future<void> setIsDarkTheme(bool isDarkTheme);
  Future<void> setContainsWallet(bool containsWallet);
  Future<void> clearCurrentAccountIndex();
  Future<void> clearSettings();
  Future<void> setLastConnectedNetworkId(int networkId);
  Future<Settings> loadSettings();
}
import 'package:kriptum/data/models/settings.dart';
import 'package:kriptum/data/services/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsServiceImpl implements SettingsService {
  @override
  Future<void> setCurrentAccountIndex(int currentAccountIndex) async {
    final sh = await SharedPreferences.getInstance();
    await sh.setInt('currentAccountIndex', currentAccountIndex);
  }

  @override
  Future<void> setIsDarkTheme(bool isDarkTheme) async {
    final sh = await SharedPreferences.getInstance();
    await sh.setBool('isDarkTheme', isDarkTheme);
  }

  @override
  Future<Settings> loadSettings() async {
    final sh = await SharedPreferences.getInstance();

    bool? isDarkTheme = sh.getBool('isDarkTheme');
    int? currentAccountIndex = sh.getInt('currentAccountIndex');
    bool? containsWallet = sh.getBool('containsWallet');
    int? lastConnectedChainId = sh.getInt('lastConnectedChainId');
    bool? isLockedWallet = sh.getBool('isLockedWallet');
    bool? hideBalance = sh.getBool('hideBalance');
    int? nextHdAccountIndex = sh.getInt('nextHdAccountIndex');
    return Settings(
        hideBalance: hideBalance ?? false,
        lastConnectedIndex: currentAccountIndex ?? 0,
        isDarkTheme: isDarkTheme ?? false,
        containsWallet: containsWallet ?? false,
        lastConnectedChainId: lastConnectedChainId ?? 1337,
        isLockedWallet: isLockedWallet ?? true,
        nextHdAccountIndex: nextHdAccountIndex ?? 1);
  }

  @override
  Future<void> setContainsWallet(bool containsWallet) async {
    final sh = await SharedPreferences.getInstance();
    await sh.setBool('containsWallet', containsWallet);
  }

  @override
  Future<void> clearCurrentAccountIndex() async {
    final sh = await SharedPreferences.getInstance();
    await sh.remove('currentAccountIndex');
  }

  @override
  Future<void> setLastConnectedNetworkId(int networkId) async {
    final sh = await SharedPreferences.getInstance();
    await sh.setInt('lastConnectedChainId', networkId);
  }

  @override
  Future<void> clearSettings() async {
    final sh = await SharedPreferences.getInstance();
    await sh.clear();
  }

  @override
  Future<void> setIsLockedWallet(bool isLockedWallet) async {
    final sh = await SharedPreferences.getInstance();
    await sh.setBool('isLockedWallet', isLockedWallet);
  }

  @override
  Future<void> setHideBalance(bool hideBalance) async {
    final sh = await SharedPreferences.getInstance();
    await sh.setBool('hideBalance', hideBalance);
  }
  
  @override
  Future<void> setNextHdAccountIndex(int nextHdAccountIndex)async {
    final sh = await SharedPreferences.getInstance();
    await sh.setInt('nextHdAccountIndex', nextHdAccountIndex);
  }
}

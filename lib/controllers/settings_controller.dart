// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:kriptum/data/models/settings.dart';
// import 'package:kriptum/interfaces/late_initializable.dart';
// import 'package:kriptum/interfaces/saveable.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsController implements LateInitializable, Saveable {
//   final _settingsKey = 'settings';
//   late Settings settings;
//   late SharedPreferences sh;

//   @override
//   Future<void> initialize() async {
//     sh = await SharedPreferences.getInstance();
//     final String? savedSettings = sh.getString(_settingsKey);
//     if (savedSettings == null) {
//       settings = Settings(lastConnectedIndex: 0, isDarkTheme: false);
//     } else {
//       settings = Settings.fromJson(savedSettings);
//     }
//   }

//   @override
//   Future<void> save() async {
//     String jsonSettings = settings.toJson();
//     await sh.setString(_settingsKey, jsonSettings);
//   }
// }

import 'package:flutter/material.dart';
import 'package:kriptum/data/models/settings.dart';
import 'package:kriptum/data/services/settings_service.dart';
import 'package:kriptum/shared/interfaces/late_initializable.dart';

class SettingsController extends ChangeNotifier implements LateInitializable {
  late Settings _settings;
  final SettingsService settingsService;
  SettingsController({
    required this.settingsService,
  });

  Settings get settings => _settings;
  @override
  Future<void> initialize() async {
    _settings = await settingsService.loadSettings();
  }
  Future<void> clearWalletConfig()async {
    _settings.lastConnectedIndex = 0;
    await settingsService.clearCurrentAccountIndex();
    await setContainsWallet(false);
    notifyListeners();
  }
  Future<void> toggleTheme() async {
    _settings.isDarkTheme = !_settings.isDarkTheme;
    await settingsService.setIsDarkTheme(_settings.isDarkTheme);
    notifyListeners();
  }
  Future<void> changeCurrentAccountIndex(int currentAccountIndex)async{
    _settings.lastConnectedIndex = currentAccountIndex;
    await settingsService.setCurrentAccountIndex(currentAccountIndex);
    notifyListeners();
  }
  Future<void> setContainsWallet(bool containsWallet)async{
    _settings.containsWallet = containsWallet;
    await settingsService.setContainsWallet(containsWallet);
    notifyListeners();
  }
  Future<void> setIsLockedWallet(bool isLockedWallet) async {
    _settings.isLockedWallet = isLockedWallet;
    await settingsService.setIsLockedWallet(isLockedWallet);
    
  }
  Future<void> changeLastConnectedNetworkId(int networkId)async {
    _settings.lastConnectedChainId = networkId;
    await settingsService.setLastConnectedNetworkId(networkId);
    notifyListeners();
  }
  Future<void> setHideBalance(bool hideBalance) async {
    _settings.hideBalance = hideBalance;
    await settingsService.setHideBalance(hideBalance);
    notifyListeners();
  }
  Future<void> setNextHdAccountIndex(int nextHdAccountIndex) async {
    _settings.nextHdAccountIndex = nextHdAccountIndex;
    await settingsService.setNextHdAccountIndex(nextHdAccountIndex);
  }
}

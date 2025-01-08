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
    return Settings(
        lastConnectedIndex: currentAccountIndex ?? 0,
        isDarkTheme: isDarkTheme ?? false);
  }
}

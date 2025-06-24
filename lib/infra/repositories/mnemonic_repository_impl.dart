import 'package:kriptum/domain/repositories/mnemonic_repository.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';

class MnemonicRepositoryImpl implements MnemonicRepository {
  final UserPreferences _userPreferences;

  MnemonicRepositoryImpl(this._userPreferences);
  @override
  Future<String> retrieveEncryptedMnemonic() async {
    return await _userPreferences.getEncryptedMnemonic();
  }

  @override
  Future<void> storeEncryptedMnemonic(String encryptedMnemonic) async {
    return await _userPreferences.setEncryptedMnemonic(encryptedMnemonic);
  }
}

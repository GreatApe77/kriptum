import 'package:kriptum/domain/factories/mnemonic_factory.dart';
import 'package:kriptum/domain/models/mnemonic.dart';
import 'package:kriptum/shared/utils/result.dart';

class MnemonicFactoryImpl implements MnemonicFactory {
  @override
  Result<Mnemonic, String> create(String mnemonicPhrase) {
    try {
      final mnemonic = Mnemonic(mnemonicPhrase);
      return Result.success(mnemonic);
    } on ArgumentError catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('An unexpected error occurred: ${e.toString()}');
    }
  }
}

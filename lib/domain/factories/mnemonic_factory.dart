import 'package:kriptum/domain/models/mnemonic.dart';
import 'package:kriptum/shared/contracts/factory.dart';
import 'package:kriptum/shared/utils/result.dart';

abstract interface class MnemonicFactory implements Factory<String, Mnemonic, String> {
  /// Creates a [Mnemonic] instance from the provided [mnemonicPhrase].
  ///
  /// Returns a [Result] containing the created [Mnemonic] on success,
  /// or a failure message on error.
  @override
  Result<Mnemonic, String> create(String mnemonicPhrase);
  
}
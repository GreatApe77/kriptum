import 'package:kriptum/shared/utils/result.dart';

class Mnemonic {
  final String phrase;

  Mnemonic._private(this.phrase);

  static Result<Mnemonic, String> create(String phrase) {
    if (phrase.isEmpty) {
      return Result.failure('Mnemonic phrase cannot be empty');
    }
    if (phrase.split(' ').length != 12) {
      return Result.failure('Mnemonic phrase must contain 12 words');
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(phrase)) {
      return Result.failure(
          'Mnemonic phrase can only contain letters and spaces');
    }
    return Result.success(
      Mnemonic._private(phrase),
    );
  }
}

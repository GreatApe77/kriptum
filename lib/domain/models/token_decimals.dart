import 'package:kriptum/shared/utils/result.dart';

class TokenDecimals {
  final int value;
  TokenDecimals._(this.value);
  static Result<TokenDecimals, String> create(int tokenDecimals) {
    if (tokenDecimals < 0) {
      return Result.failure('Cannot be negative');
    }

    return Result.success(TokenDecimals._(tokenDecimals));
  }
}

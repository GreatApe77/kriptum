import 'package:kriptum/shared/utils/result.dart';

class TokenName {
  static const _maxWidth = 20;
  final String value;
  TokenName._(this.value);

  static Result<TokenName, String> create(String tokenName) {
    final trimmed = tokenName.trim();
    if (trimmed.length > _maxWidth) {
      return Result.failure('Token name must be lower or equal to $_maxWidth chars');
    }
    return Result.success(TokenName._(trimmed));
  }
}

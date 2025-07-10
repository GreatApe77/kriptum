import 'package:kriptum/shared/utils/result.dart';

class TokenSymbol {
  static const _maxWidth = 10;
  final String value;
  TokenSymbol._(this.value);

  static Result<TokenSymbol, String> create(String symbol) {
    final trimmed = symbol.trim();
    if (trimmed.length > _maxWidth) {
      return Result.failure('Symbol must be lower or equal to $_maxWidth chars');
    }
    return Result.success(TokenSymbol._(trimmed));
  }

  String upperCased(){
    return value.toUpperCase();
  }
}
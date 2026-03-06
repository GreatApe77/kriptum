part 'invalid_current_account_state_exception.dart';
part 'invalid_ethereum_address_exception.dart';
part 'not_enough_balance_exception.dart';
part 'passwords_dont_match_or_are_empty_exception.dart';
part 'cannot_add_yourself_exception.dart';
part 'invalid_token_name_exception.dart';
part 'invalid_token_symbol_exception.dart';
part 'invalid_token_decimals_exception.dart';
part 'invalid_stored_password_exception.dart';
part 'erc20_token_already_imported_exception.dart';
part 'wrong_password_exception.dart';
part 'account_already_exists_exception.dart';
sealed class DomainException implements Exception {
  final String _reason;
  DomainException(String reason) : _reason = reason;

  String getReason() => _reason;
}

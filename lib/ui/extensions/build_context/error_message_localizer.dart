import 'package:flutter/material.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/exceptions/invalid_current_account_state_exception.dart';
import 'package:kriptum/domain/exceptions/invalid_ethereum_address_exception.dart';
import 'package:kriptum/domain/usecases/add_contact_usecase.dart';
import 'package:kriptum/domain/usecases/add_hd_wallet_account_usecase.dart';
import 'package:kriptum/domain/usecases/import_account_from_private_key_usecase.dart';
import 'package:kriptum/domain/usecases/import_erc20_token_usecase.dart';
import 'package:kriptum/domain/usecases/unlock_wallet_usecase.dart';
import 'package:kriptum/l10n/app_localizations.dart';

extension ErrorMessageLocalizer on BuildContext {
  String localize(Exception exception) {
    final l10n = AppLocalizations.of(this)!;
    if(exception is! DomainException) {
      return l10n.errorUnknown;
    }
    switch (exception) {
      case InvalidCurrentAccountStateException():
        return l10n.errorInvalidCurrentAccountState;
      case InvalidEthereumAddressException():
        return exception.getReason();
      case CannotAddYourselfException():
        return l10n.errorCannotAddYourself;
      case WrongPasswordException():
        return l10n.errorWrongPassword;
      case AccountAlreadyExistsException():
        return l10n.errorAccountAlreadySaved;
      case InvalidStoredPasswordException():
        return exception.getReason();
      case InvalidTokenNameException():
        return exception.getReason();
      case InvalidTokenDecimalsException():
        return exception.getReason();
      case InvalidTokenSymbolException():
        return exception.getReason();
      case Erc20TokenAlreadyImportedException():
        return l10n.errorTokenAlreadyImported;
      default:
        return l10n.errorUnknown;
    }
  }
}
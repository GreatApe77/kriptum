import 'package:flutter/material.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';

import 'package:kriptum/l10n/app_localizations.dart';

extension ErrorMessageLocalizer on BuildContext {
  String localize(Exception exception) {
    final l10n = AppLocalizations.of(this)!;
    if (exception is! DomainException) {
      return l10n.errorUnknown;
    }

    switch (exception) {
      case InvalidCurrentAccountStateException():
        return l10n.errorInvalidCurrentAccountState;
      case InvalidEthereumAddressException():
        return exception.getReason();
      case NotEnoughBalanceException():
        return l10n.notEnoughBalance;
      case PasswordsDontMatchOrAreEmptyException():
        return l10n.passwordsDontMatchOrAreEmpty;
      case CannotAddYourselfException():
        return l10n.errorCannotAddYourself;
      case InvalidTokenNameException():
        return exception.getReason();
      case InvalidTokenSymbolException():
        return exception.getReason();
      case InvalidTokenDecimalsException():
        return exception.getReason();
      case InvalidStoredPasswordException():
        return exception.getReason();
      case Erc20TokenAlreadyImportedException():
        return l10n.errorTokenAlreadyImported;
      case WrongPasswordException():
        return l10n.errorWrongPassword;
      case AccountAlreadyExistsException():
        return l10n.errorAccountAlreadySaved;
    }
  }
}
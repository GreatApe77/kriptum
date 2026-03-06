import 'package:kriptum/domain/exceptions/domain_exception.dart';

class PasswordsDontMatchOrAreEmptyException extends DomainException {
  PasswordsDontMatchOrAreEmptyException(super.reason);
}

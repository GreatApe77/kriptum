import 'package:kriptum/domain/exceptions/domain_exception.dart';

class NotEnoughBalanceException extends DomainException {
  NotEnoughBalanceException(super.reason);
}

import 'package:kriptum/domain/models/account.dart';

abstract class AccountRepository {
  
  Future<void> saveAccount(Account account);
  Future<Account> getAccount(int index);
}

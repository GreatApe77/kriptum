import 'package:kriptum/domain/models/account.dart';

abstract class AccountRepository {
  Future<void> updateAccount(int index,Account account);
  Future<void> saveAccount(Account account);
  Future<Account> getAccount(int index);
  Future<void> clearAccounts();
  Future<List<Account>> getAccounts();
}

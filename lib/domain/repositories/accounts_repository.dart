import 'package:kriptum/domain/models/account.dart';

abstract interface class AccountsRepository {
  Future<List<Account>> getAccounts();
  Future<int> getCurrentIndex();
  Stream<List<Account>> watchAccounts();
  Stream<Account> currentAccountStream();
  Future<Account?> getCurrentAccount();
  Future<void> changeCurrentAccount(Account account);
  Future<void> saveAccounts(List<Account> accounts);
  Future<void> deleteAllAccounts();
  Future<void> updateAccount(Account account);
}

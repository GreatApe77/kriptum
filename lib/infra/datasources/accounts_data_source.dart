import 'package:kriptum/domain/models/account.dart';

abstract interface class AccountsDataSource {
  Future<List<Account>> getAllAccounts();
  Future<int> insertAccount(Account account);
  Future<Account?> getAccountById(int id);
  Future<void> insertAccounts(List<Account> accounts);
  Future<void> deleteAllAccounts();
  Future<void> updateAccount(Account account);
  Future<List<Account>> getAllNonImportedAccounts();
}

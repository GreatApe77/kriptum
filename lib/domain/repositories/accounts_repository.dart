import 'package:kriptum/domain/models/account.dart';

abstract interface class AccountsRepository {
  Future<List<Account>> getAccounts();
  Stream<Account> currentAccountStream();
  Future<Account?> getCurrentAccount();
  Future<void> saveAccounts(List<Account> accounts);
  Future<void> deleteAllAccounts();
}

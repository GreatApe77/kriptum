import 'package:kriptum/domain/models/account.dart';

abstract interface class AccountsRepository {
  Future<List<Account>> getAccounts();
  Stream<Account> currentAccountStream();
  Future<void> saveAccounts(List<Account> accounts);
}

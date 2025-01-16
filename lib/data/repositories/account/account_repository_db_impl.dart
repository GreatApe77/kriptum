import 'package:kriptum/data/database/accounts_table.dart';
import 'package:kriptum/data/database/sqlite_database.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/domain/models/account.dart';

class AccountRepositoryDbImpl implements AccountRepository {
  @override
  Future<Account> getAccount(int index) async {
    final database = await SqliteDatabase().db;
    final result = await database.query(AccountsTable.table,
        where: '${AccountsTable.accountIndexColumn} = ?', whereArgs: [index]);
    if (result.isEmpty) {
      throw Exception('Not Found');
    }
    return Account.fromMap(result[0]);
  }

  @override
  Future<void> saveAccount(Account account) async {
    final database = await SqliteDatabase().db;
    await database.insert(AccountsTable.table, account.toMap());
  }

  @override
  Future<void> clearAccounts() async {
    final database = await SqliteDatabase().db;
    await database.delete(AccountsTable.table);
  }

  @override
  Future<List<Account>> getAccounts() async {
    final database = await SqliteDatabase().db;
    final queryResult = await database.query(AccountsTable.table);
    return queryResult
        .map(
          (accountMap) => Account.fromMap(accountMap),
        )
        .toList();
  }

  @override
  Future<void> updateAccount(int index, Account account) async {
    final database = await SqliteDatabase().db;
    
        await database.update(AccountsTable.table, account.toMap(),
        where: '${AccountsTable.accountIndexColumn} = ?',
        whereArgs: [index]);

  }
}

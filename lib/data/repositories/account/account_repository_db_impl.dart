import 'package:kriptum/data/database/accounts_table.dart';
import 'package:kriptum/data/database/sqlite_database.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/domain/models/account.dart';

class AccountRepositoryDbImpl implements AccountRepository {
  @override
  Future<Account> getAccount(int index) async {
    final database = await SqliteDatabase().db;
    final result = await database.query(AccountsTable.table,
        where: '${AccountsTable.indexColumn} = ?', whereArgs: [index]);
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
}

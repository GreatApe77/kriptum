import 'package:kriptum/infra/datasources/accounts_data_source.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/accounts_table.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';

class AccountsDataSourceImpl implements AccountsDataSource {
  final SqlDatabase _sqlDatabase;

  AccountsDataSourceImpl({
    required SqlDatabase sqlDatabase,
  }) : _sqlDatabase = sqlDatabase;
  @override
  Future<Account?> getAccountById(int id) async {
    final account = await _sqlDatabase.query(
      AccountsTable.table,
      where: '${AccountsTable.accountIndexColumn} = ?',
      whereArgs: [id],
    );
    if (account.isEmpty) {
      return null;
    }
    final accountData = account.first;
    return Account.fromMap(accountData);
  }

  @override
  Future<List<Account>> getAllAccounts() async {
    final accountsData = await _sqlDatabase.query(AccountsTable.table);
    return accountsData.map((account) => Account.fromMap(account)).toList();
  }

  @override
  Future<int> insertAccount(Account account) async {
    final accountMap = account.toMap();
    return await _sqlDatabase.insert(
      AccountsTable.table,
      accountMap,
    );
  }

  @override
  Future<void> insertAccounts(List<Account> accounts) async {
    for (final accounts in accounts) {
      final accountMap = accounts.toMap();
      await _sqlDatabase.insert(AccountsTable.table, accountMap);
    }
  }
}

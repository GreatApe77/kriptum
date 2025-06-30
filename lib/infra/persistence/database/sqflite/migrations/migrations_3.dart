import 'package:kriptum/infra/persistence/database/sqflite/tables/accounts_table.dart';
import 'package:sqflite/sqflite.dart';

Future<void> runMigration3(Database db) async {
  await db.execute('ALTER TABLE ${AccountsTable.table} RENAME TO ${AccountsTable.table}_old;');

  await db.execute('''
    CREATE TABLE ${AccountsTable.table} (
      ${AccountsTable.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AccountsTable.accountIndexColumn} INTEGER,
      ${AccountsTable.addressColumn} VARCHAR(255),
      ${AccountsTable.encryptedJsonWalletColumn} TEXT,
      ${AccountsTable.aliasColumn} VARCHAR(255),
      ${AccountsTable.isImportedColumn} INTEGER
    );
  ''');

  await db.execute('''
    INSERT INTO ${AccountsTable.table} (
      ${AccountsTable.accountIndexColumn},
      ${AccountsTable.addressColumn},
      ${AccountsTable.encryptedJsonWalletColumn},
      ${AccountsTable.aliasColumn},
      ${AccountsTable.isImportedColumn}
    )
    SELECT 
      ${AccountsTable.accountIndexColumn},
      ${AccountsTable.addressColumn},
      ${AccountsTable.encryptedJsonWalletColumn},
      ${AccountsTable.aliasColumn},
      ${AccountsTable.isImportedColumn}
    FROM ${AccountsTable.table}_old;
  ''');

  await db.execute('DROP TABLE ${AccountsTable.table}_old;');
}

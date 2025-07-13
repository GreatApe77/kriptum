import 'package:kriptum/infra/persistence/database/sqflite/tables/accounts_table.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/erc20_tokens_table.dart';
import 'package:sqflite/sqflite.dart';

Future<void> runMigration4(Database db) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS ${Erc20TokensTable.table} (
      ${Erc20TokensTable.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Erc20TokensTable.columnContractAddress} VARCHAR(42) UNIQUE NOT NULL,
      ${Erc20TokensTable.columnName} VARCHAR(20),
      ${Erc20TokensTable.columnSymbol} VARCHAR(10),
      ${Erc20TokensTable.columnDecimals} INTEGER,
      ${Erc20TokensTable.columnLogoUrl} TEXT,
      ${Erc20TokensTable.columnNetworkId} INTEGER,
      FOREIGN KEY (${Erc20TokensTable.columnNetworkId}) REFERENCES ${AccountsTable.table}(${AccountsTable.idColumn})
    );
  ''');
}

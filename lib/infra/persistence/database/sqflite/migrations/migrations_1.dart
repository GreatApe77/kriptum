import 'package:kriptum/infra/persistence/database/sqflite/seed/seed_networks.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/accounts_table.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/networks_table.dart';
import 'package:sqflite/sqflite.dart';



Future<void> runMigration1(Database db) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS ${AccountsTable.table}(
      ${AccountsTable.accountIndexColumn} INTEGER PRIMARY KEY,
      ${AccountsTable.addressColumn} VARCHAR(255),
      ${AccountsTable.encryptedJsonWalletColumn} TEXT,
      ${AccountsTable.aliasColumn} VARCHAR(255),
      ${AccountsTable.isImportedColumn} INTEGER
    );
  ''');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS ${NetworksTable.table}(
      ${NetworksTable.idColumn} INTEGER PRIMARY KEY NOT NULL,
      ${NetworksTable.rpcUrlColumn} VARCHAR(255) NOT NULL,
      ${NetworksTable.nameColumn} VARCHAR(255) NOT NULL,
      ${NetworksTable.blockExplorerNameColumn} VARCHAR(255),
      ${NetworksTable.blockExplorerUrlColumn} VARCHAR(255),
      ${NetworksTable.tickerColumn} VARCHAR(10) NOT NULL,
      ${NetworksTable.currencyDecimalsColumn} INTEGER NOT NULL
    );
  ''');

  final batch = db.batch();
  for (var network in seedNetworks) {
    batch.insert(NetworksTable.table, network.toMap());
  }
  await batch.commit();
}

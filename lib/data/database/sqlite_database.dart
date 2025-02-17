import 'package:kriptum/data/database/accounts_table.dart';
import 'package:kriptum/data/database/contacts_table.dart';
import 'package:kriptum/data/database/networks_table.dart';
import 'package:kriptum/ui/shared/constants/standard_networks.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  static const _dbVersion=2;
  static final _instance = SqliteDatabase._internal();

  SqliteDatabase._internal();

  factory SqliteDatabase() => _instance;

  final _dbFileName = 'kriptum.db';
  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await initializeDb();
    return _db!;
  }

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, _dbFileName);

    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (db, version) async {
        await _createAccountsTable(db);
        await _createNetworksTable(db);
        await _createContactsTable(db);
        await _insertStandardChains(db);
      },
      onUpgrade: (db, oldVersion, newVersion)async {
        if(oldVersion<2){
          await _upgradeV2(db);
        }
      },
    );
  }
  
  Future<void> _createAccountsTable(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${AccountsTable.table}(
          ${AccountsTable.accountIndexColumn} INTEGER PRIMARY KEY,
          ${AccountsTable.addressColumn} VARCHAR(255),
          ${AccountsTable.encryptedJsonWalletColumn} TEXT,
          ${AccountsTable.aliasColumn} VARCHAR(255),
          ${AccountsTable.isImportedColumn} INTEGER
        );

      ''');
  }

  Future<void> _insertStandardChains(Database db) async {
    final batch = db.batch();
    for (var i = 0; i < standardNetworks.length; i++) {
      batch.insert(NetworksTable.table, standardNetworks[i].toMap());
    }
    await batch.commit();
  }

  Future<void> _createNetworksTable(Database db) async {
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
  }

  Future<void> _createContactsTable(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${ContactsTable.table}(
          ${ContactsTable.idColumn} INTEGER PRIMARY KEY NOT NULL,
          ${ContactsTable.nameColumn} VARCHAR(255) NOT NULL,
          ${ContactsTable.addressColumn} VARCHAR(42) UNIQUE NOT NULL 
        );
      ''');
  }
  Future<void> _upgradeV2(Database db) async {
    await _createContactsTable(db);
  }
}

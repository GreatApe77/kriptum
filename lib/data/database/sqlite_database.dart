import 'package:kriptum/data/database/accounts_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
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
      version: 1,
      onCreate: (db, version) async {
        await _createAccountsTable(db);
      },
    );
  }

  Future<void> _createAccountsTable(Database db) async {
    await db.execute('''
        CREATE TABLE ${AccountsTable.table}(
          ${AccountsTable.accountIndexColumn} INTEGER PRIMARY KEY,
          ${AccountsTable.addressColumn} TEXT,
          ${AccountsTable.encryptedJsonWalletColumn} TEXT
        );

      ''');
  }
}

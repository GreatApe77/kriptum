import 'package:kriptum/infra/persistence/database/database.dart';
import 'package:kriptum/infra/persistence/database/sqflite/run_migrations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class SqfliteDatabase implements Database {
  static const _dbVersion = 2;
  final _dbFileName = 'kriptum.db';
  sqflite.Database? _database;
  static final SqfliteDatabase _instance = SqfliteDatabase._internal();
  factory SqfliteDatabase() {
    return _instance;
  }
  SqfliteDatabase._internal();
  Future<sqflite.Database> _getDatabase() async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await _initializeDatabase();
    }
    return _database!;
  }

  Future<sqflite.Database> _initializeDatabase() async {
    String path = await sqflite.getDatabasesPath();
    String dbPath = join(path, _dbFileName);
    return await sqflite.openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (db, version) async {
        await runMigrations(db, 0, _dbVersion);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await runMigrations(db, oldVersion, newVersion);
      },
    );
  }

  @override
  Future<int> delete(String table, String where, List<Object?> whereArgs) {
    // TODO: implement query
    throw UnimplementedError();
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> values) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table) {
    // TODO: implement query
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() async {
    await _getDatabase();
  }
}

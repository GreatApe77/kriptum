import 'package:kriptum/infra/persistence/database/sqflite/tables/contacts_table.dart';
import 'package:sqflite/sqflite.dart';

Future<void> runMigration2(Database db) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS ${ContactsTable.table}(
      ${ContactsTable.idColumn} INTEGER PRIMARY KEY NOT NULL,
      ${ContactsTable.nameColumn} VARCHAR(255) NOT NULL,
      ${ContactsTable.addressColumn} VARCHAR(42) UNIQUE NOT NULL 
    );
  ''');
}

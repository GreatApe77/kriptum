import 'package:kriptum/data/database/contacts_table.dart';
import 'package:kriptum/data/database/sqlite_database.dart';
import 'package:kriptum/data/repositories/contact/contacts_repository.dart';
import 'package:kriptum/domain/exceptions/contact_not_found_exception.dart';
import 'package:kriptum/domain/exceptions/duplicated_contact_exception.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactsRepositoryDbImpl implements ContactsRepository {
  @override
  Future<void> deleteContact(int id) async {
    final database = await SqliteDatabase().db;
    await database.delete(ContactsTable.table,
        where: '${ContactsTable.idColumn} = ?', whereArgs: [id]);
  }

  @override
  Future<Contact> getContact(int id) async {
    final database = await SqliteDatabase().db;
    final res = await database.query(ContactsTable.table,
        where: '${ContactsTable.idColumn} = ?', whereArgs: [id]);
    if (res.isEmpty) {
      throw ContactNotFoundException();
    }
    return Contact.fromMap(res.first);
  }

  @override
  Future<List<Contact>> getContacts() async {
    final database = await SqliteDatabase().db;
    final res = await database.query(ContactsTable.table);
    return res.map((e) => Contact.fromMap(e)).toList();
  }

  @override
  Future<int> saveContact(Contact contact) async {
    final database = await SqliteDatabase().db;
    final result = await database.insert(ContactsTable.table, contact.toMap());
    return result;
  }

  @override
  Future<void> updateContact(int id, Contact contactData) async {
    try {
      final database = await SqliteDatabase().db;
      await database.update(
        ContactsTable.table,
        contactData.toMap(),
        where: '${ContactsTable.idColumn} = ?',
        whereArgs: [id],
      );
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw DuplicatedContactException();
      }
    }
  }
}

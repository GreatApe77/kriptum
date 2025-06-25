import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/infra/datasources/contacts_data_source.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/contacts_table.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';

class ContactsDataSourceImpl implements ContactsDataSource {
  final SqlDatabase _sqlDatabase;

  ContactsDataSourceImpl(this._sqlDatabase);

  @override
  Future<void> deleteContact(int contactId) async {
    await _sqlDatabase.delete(
      ContactsTable.table,
      '${ContactsTable.idColumn} = ?',
      [contactId],
    );
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    final result = await _sqlDatabase.query(ContactsTable.table);
    return result
        .map(
          (e) => Contact.fromMap(e),
        )
        .toList();
  }

  @override
  Future<int> saveContact(Contact contact) async {
    final insertedId = await _sqlDatabase.insert(
      ContactsTable.table,
      contact.toMap(),
    );
    return insertedId;
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await _sqlDatabase.update(
      ContactsTable.table,
      contact.toMap(),
      where: '${ContactsTable.idColumn} = ${contact.id}',
      whereArgs: [contact.id],
    );
  }

  @override
  Future<void> deleteAllContacts() async {
    await _sqlDatabase.deleteAll(ContactsTable.table);
  }
}

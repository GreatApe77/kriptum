import 'dart:async';

import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';
import 'package:kriptum/infra/datasources/contacts_data_source.dart';
import 'package:kriptum/shared/contracts/disposable.dart';

class ContactsRepositoryImpl implements ContactsRepository, Disposable {
  List<Contact> _contacts = [];
  final StreamController<List<Contact>> _contactsStream =
      StreamController.broadcast();

  final ContactsDataSource _contactsDataSource;

  ContactsRepositoryImpl(this._contactsDataSource);

  @override
  Future<void> deleteContact(int contactId) async {
    
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    _contacts = await _contactsDataSource.getAllContacts();
    return _contacts;
  }

  @override
  Future<void> saveContact(Contact contact) async {
    final insertedId = await _contactsDataSource.saveContact(contact);
    final contactWithId = contact.copyWith(id: insertedId);
    _contacts.add(contactWithId);
    _contactsStream.add(_contacts);
  }

  @override
  Future<void> updateContact(Contact contact) {
    // TODO: implement updateContact
    throw UnimplementedError();
  }

  @override
  Stream<List<Contact>> watchContacts() => _contactsStream.stream;

  @override
  Future<void> dispose() async {
    _contactsStream.close();
  }
}

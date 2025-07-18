import 'dart:async';

import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';
import 'package:kriptum/infra/datasources/data_sources.dart';
import 'package:kriptum/shared/contracts/disposable.dart';

class ContactsRepositoryImpl implements ContactsRepository, Disposable {
  List<Contact> _contacts = [];
  final StreamController<List<Contact>> _contactsStream = StreamController.broadcast();

  final ContactsDataSource _contactsDataSource;

  ContactsRepositoryImpl(this._contactsDataSource);

  @override
  Future<void> deleteContact(int contactId) async {
    await _contactsDataSource.deleteContact(contactId);
    _contacts.removeWhere(
      (contact) => contact.id == contactId,
    );
    _contactsStream.add(_contacts);
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
  Future<void> updateContact(Contact contact) async {
    await _contactsDataSource.updateContact(contact);
    final contactPosition = _contacts.indexWhere(
      (element) => element.id == contact.id,
    );
    _contacts[contactPosition] = contact;
    _contactsStream.add(_contacts);
  }

  @override
  Stream<List<Contact>> watchContacts() => _contactsStream.stream;

  @override
  Future<void> dispose() async {
    _contactsStream.close();
  }

  @override
  Future<void> deleteAllContacts() async {
    await _contactsDataSource.deleteAllContacts();
    _contacts = [];
    _contactsStream.add(_contacts);
  }
}

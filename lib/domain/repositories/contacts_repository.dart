import 'package:kriptum/domain/models/contact.dart';

abstract interface class ContactsRepository {
  Future<void> saveContact(Contact contact);
  Future<List<Contact>> getAllContacts();
  Stream<List<Contact>> watchContacts();
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(int contactId);

}
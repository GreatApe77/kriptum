import 'package:kriptum/domain/models/contact.dart';

abstract interface class ContactsDataSource {
  Future<int> saveContact(Contact contact);
  Future<List<Contact>> getAllContacts();
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(int contactId);
}

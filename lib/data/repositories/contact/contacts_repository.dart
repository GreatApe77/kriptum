import 'package:kriptum/domain/models/contact.dart';

abstract class ContactsRepository {
  Future<int> saveContact(Contact contact);
  Future<List<Contact>> getContacts();
  Future<void> updateContact(int id,Contact contactData);
  Future<Contact> getContact(int id);
  Future<void> deleteContact(int id);
}
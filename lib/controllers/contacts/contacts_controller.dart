import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/contact/contacts_repository.dart';
import 'package:kriptum/domain/models/contact.dart';

class ContactsController extends ChangeNotifier {
  final ContactsRepository _contactsRepository;
  List<Contact> _contacts = [];

  ContactsController({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository;

  List<Contact> get contacts => _contacts;

  Future<void> updateContact(
      {required int contactId,
      required Contact editedContactData,
      required Function() onSuccess,
      required Function() onFail}) async {
    try {
      await _contactsRepository.updateContact(contactId, editedContactData);
      int idx = _contacts.indexWhere(
        (element) => element.id == contactId,
      );
      _contacts[idx] = editedContactData;
      onSuccess();
      notifyListeners();
    } catch (e) {
      onFail();
    }
  }

  Future<void> deleteContact(
      {required Contact contact,
      required Function() onSuccess,
      required Function() onFail}) async {
    try {
      await _contactsRepository.deleteContact(contact.id!);
      _contacts.removeWhere(
        (element) => element.id == contact.id,
      );
      notifyListeners();
      onSuccess();
    } catch (e) {
      onFail();
    }
  }

  Future<void> loadContacts() async {
    _contacts = await _contactsRepository.getContacts();
    notifyListeners();
  }

  Future<void> addContact(
      {required String name,
      required String address,
      required Function() onSuccess,
      required Function() onError,
      required Function() onExistingContact}) async {
    try {
      Contact contact = Contact(name: name, address: address);
      final indexWhere = _contacts.indexWhere(
        (element) => element.address == address,
      );
      if (indexWhere == -1) {
        int insertedId = await _contactsRepository.saveContact(contact);
        contact.id = insertedId;
        _contacts.add(contact);
        notifyListeners();
        onSuccess();
      } else {
        onExistingContact();
      }
    } catch (e) {
      onError();
    }
  }
}

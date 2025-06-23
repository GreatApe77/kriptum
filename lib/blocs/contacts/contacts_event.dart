part of 'contacts_bloc.dart';

sealed class ContactsEvent {}

final class ContactsRequested extends ContactsEvent {}

final class ContactDeletionRequested extends ContactsEvent {
  final int contactId;

  ContactDeletionRequested({required this.contactId});
}


final class ContactUpdateRequested extends ContactsEvent {
  final Contact contact;

  ContactUpdateRequested({required this.contact});
}

final class ContactsFilteredRequested extends ContactsEvent {
  final String searchTerm;

  ContactsFilteredRequested({required this.searchTerm});
}

final class _ContactsRefreshed extends ContactsEvent {
  final List<Contact> refreshedContacts;

  _ContactsRefreshed({required this.refreshedContacts});
}

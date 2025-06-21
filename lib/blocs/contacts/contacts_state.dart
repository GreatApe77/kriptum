// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contacts_bloc.dart';

enum ContactsStatus { initial, loading, loaded, error }

class ContactsState {
  final List<Contact> contacts;
  final List<Contact> filteredContacts;
  final ContactsStatus status;
  final String errorMessage;

  ContactsState({
    required this.contacts,
    required this.filteredContacts,
    required this.status,
    required this.errorMessage,
  });

  factory ContactsState.initial() {
    return ContactsState(
      contacts: [],
      filteredContacts: [],
      status: ContactsStatus.initial,
      errorMessage: '',
    );
  }

  ContactsState copyWith({
    List<Contact>? contacts,
    List<Contact>? filteredContacts,
    ContactsStatus? status,
    String? errorMessage,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

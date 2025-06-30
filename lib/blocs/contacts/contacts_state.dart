// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contacts_bloc.dart';

enum ContactsStatus { initial, loading, loaded, error, inserted }

enum ContactUpdateStatus { idle, loading, error, success }

enum ContactDeletionStatus { idle, loading, error, success }

class ContactsState {
  final List<Contact> contacts;
  final List<Contact> filteredContacts;
  final Map<String, List<Contact>> groupedByFirstLetter;
  final ContactUpdateStatus updateStatus;
  final ContactDeletionStatus deletionStatus;
  final ContactsStatus status;
  final String errorMessage;

  ContactsState({
    required this.contacts,
    required this.filteredContacts,
    required this.status,
    required this.deletionStatus,
    required this.updateStatus,
    required this.errorMessage,
    required this.groupedByFirstLetter,
  });

  factory ContactsState.initial() {
    return ContactsState(
      groupedByFirstLetter: {},
      contacts: [],
      filteredContacts: [],
      status: ContactsStatus.initial,
      deletionStatus: ContactDeletionStatus.idle,
      updateStatus: ContactUpdateStatus.idle,
      errorMessage: '',
    );
  }

  ContactsState copyWith({
    List<Contact>? contacts,
    List<Contact>? filteredContacts,
    ContactsStatus? status,
    String? errorMessage,
    Map<String, List<Contact>>? groupedByFirstLetter,
    ContactDeletionStatus? deletionStatus,
    ContactUpdateStatus? updateStatus,
  }) {
    return ContactsState(
      deletionStatus: deletionStatus ?? this.deletionStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      groupedByFirstLetter: groupedByFirstLetter ?? this.groupedByFirstLetter,
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

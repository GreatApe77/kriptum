part of 'add_contact_bloc.dart';

sealed class AddContactEvent {}

final class AddContactRequested extends AddContactEvent {
  final Contact contact;

  AddContactRequested({required this.contact});
}

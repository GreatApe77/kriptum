part of 'add_contact_bloc.dart';

sealed class AddContactState {}

final class AddContactInitial extends AddContactState {}

final class AddContactLoading extends AddContactState {}

final class AddContactError extends AddContactState {
  final Exception error;

  AddContactError({required this.error});
}

final class AddContactSuccess extends AddContactState {}

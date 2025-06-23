import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  final ContactsRepository _contactsRepository;
  AddContactBloc(this._contactsRepository) : super(AddContactInitial()) {
    on<AddContactRequested>(_handleAddContact);
  }

  Future<void> _handleAddContact(
      AddContactRequested event, Emitter<AddContactState> emit) async {
    try {
      emit(AddContactLoading());
      await _contactsRepository.saveContact(event.contact);
      emit(AddContactSuccess());
    } catch (e) {
      emit(
        AddContactError(
          message: e.toString(),
        ),
      );
    }
  }
}

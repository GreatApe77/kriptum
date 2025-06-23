import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepository _contactsRepository;
  late final StreamSubscription _contactsSubscription;
  ContactsBloc(this._contactsRepository)
      : super(
          ContactsState.initial(),
        ) {
    _contactsSubscription = _contactsRepository.watchContacts().listen(
      (event) {
        add(_ContactsRefreshed(refreshedContacts: event));
      },
    );
    on<_ContactsRefreshed>(_handleRefresh);
    on<ContactsRequested>(_handleRequest);

    on<ContactDeletionRequested>(_handleDelete);
    on<ContactUpdateRequested>(_handleUpdate);
  }

  Future<void> _handleRequest(
      ContactsRequested event, Emitter<ContactsState> emit) async {
    try {
      emit(
        state.copyWith(status: ContactsStatus.loading),
      );
      final contacts = await _contactsRepository.getAllContacts();
      emit(
        state.copyWith(
            contacts: contacts,
            filteredContacts: contacts,
            status: ContactsStatus.loaded),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ContactsStatus.error,
          errorMessage: 'Error while loading contacts',
        ),
      );
    }
  }

  FutureOr<void> _handleDelete(
      ContactDeletionRequested event, Emitter<ContactsState> emit) {}

  FutureOr<void> _handleUpdate(
      ContactUpdateRequested event, Emitter<ContactsState> emit) {}

  FutureOr<void> _handleRefresh(
      _ContactsRefreshed event, Emitter<ContactsState> emit) {
    emit(
      state.copyWith(
        contacts: event.refreshedContacts,
        filteredContacts: event.refreshedContacts,
        status: ContactsStatus.loaded,
      ),
    );
  }

  @override
  Future<void> close() {
    _contactsSubscription.cancel();
    return super.close();
  }
}

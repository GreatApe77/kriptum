import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';
import 'package:kriptum/domain/usecases/add_contact_usecase.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  final AddContactUsecase _addContactUsecase;
  AddContactBloc(this._addContactUsecase) : super(AddContactInitial()) {
    on<AddContactRequested>(_handleAddContact);
  }

  Future<void> _handleAddContact(AddContactRequested event, Emitter<AddContactState> emit) async {
    try {
      emit(AddContactLoading());
      final params = AddContactUsecaseParams(
        contact: event.contact,
      );
      await _addContactUsecase.execute(params);
      emit(AddContactSuccess());
    } on DomainException catch (e) {
      emit(
        AddContactError(message: e.getReason()),
      );
    } catch (e) {
      emit(
        AddContactError(message: 'Unknown error'),
      );
    }
  }
}

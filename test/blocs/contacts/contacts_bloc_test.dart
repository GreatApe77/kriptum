import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/contacts/contacts_bloc.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class FakeContact extends Fake implements Contact {}

void main() {
  late ContactsBloc sut;
  late MockContactsRepository mockContactsRepository;
  late StreamController<List<Contact>> contactsStreamController;

  final testContacts = [
    Contact(id: 1, name: 'Alice', address: '0xAlice'),
    Contact(id: 2, name: 'Bob', address: '0xBob'),
    Contact(id: 3, name: 'Charlie', address: '0xCharlie'),
    Contact(id: 4, name: 'Abe', address: '0xAbe'),
  ];

  setUpAll(() {
    registerFallbackValue(FakeContact());
  });

  setUp(() {
    mockContactsRepository = MockContactsRepository();
    contactsStreamController = StreamController<List<Contact>>.broadcast();
    when(() => mockContactsRepository.watchContacts()).thenAnswer((_) => contactsStreamController.stream);
    sut = ContactsBloc(mockContactsRepository);
  });

  tearDown(() {
    contactsStreamController.close();
    sut.close();
  });

  group('ContactsBloc', () {
    test('initial state is correct', () {
      expect(sut.state, isA<ContactsState>());
      expect(sut.state.status, ContactsStatus.initial);
    });

    group('ContactsRequested', () {
      blocTest<ContactsBloc, ContactsState>(
        'emits [loading, loaded] with sorted and grouped contacts on success',
        build: () {
          when(() => mockContactsRepository.getAllContacts()).thenAnswer((_) async => testContacts);
          return sut;
        },
        act: (bloc) => bloc.add(ContactsRequested()),
        expect: () => [
          isA<ContactsState>().having((s) => s.status, 'status', ContactsStatus.loading),
          isA<ContactsState>()
              .having((s) => s.status, 'status', ContactsStatus.loaded)
              .having((s) => s.contacts, 'contacts', testContacts)
              .having((s) => s.groupedByFirstLetter.keys.toList(), 'grouped keys', ['A', 'B', 'C']),
        ],
        verify: (_) {
          verify(() => mockContactsRepository.getAllContacts()).called(1);
        },
      );

      blocTest<ContactsBloc, ContactsState>(
        'emits [loading, error] on failure',
        build: () {
          when(() => mockContactsRepository.getAllContacts()).thenThrow(Exception('Failed to load'));
          return sut;
        },
        act: (bloc) => bloc.add(ContactsRequested()),
        expect: () => [
          isA<ContactsState>().having((s) => s.status, 'status', ContactsStatus.loading),
          isA<ContactsState>()
              .having((s) => s.status, 'status', ContactsStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', 'Error while loading contacts'),
        ],
      );
    });

    group('ContactDeletionRequested', () {
      blocTest<ContactsBloc, ContactsState>(
        'emits [loading, success] for deletion status on success',
        build: () {
          when(() => mockContactsRepository.deleteContact(any())).thenAnswer((_) async {});
          return sut;
        },
        act: (bloc) => bloc.add(ContactDeletionRequested(contactId: 1)),
        expect: () => [
          isA<ContactsState>().having((s) => s.deletionStatus, 'deletionStatus', ContactDeletionStatus.loading),
          isA<ContactsState>().having((s) => s.deletionStatus, 'deletionStatus', ContactDeletionStatus.success),
        ],
        verify: (_) {
          verify(() => mockContactsRepository.deleteContact(1)).called(1);
        },
      );

      blocTest<ContactsBloc, ContactsState>(
        'emits [loading, error] for deletion status on failure',
        build: () {
          when(() => mockContactsRepository.deleteContact(any())).thenThrow(Exception('Failed to delete'));
          return sut;
        },
        act: (bloc) => bloc.add(ContactDeletionRequested(contactId: 1)),
        expect: () => [
          isA<ContactsState>().having((s) => s.deletionStatus, 'deletionStatus', ContactDeletionStatus.loading),
          isA<ContactsState>()
              .having((s) => s.deletionStatus, 'deletionStatus', ContactDeletionStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', 'Error while deleting contact'),
        ],
      );
    });

    group('ContactUpdateRequested', () {
      final updatedContact = Contact(id: 1, name: 'Alicia', address: '0xAlice');
      blocTest<ContactsBloc, ContactsState>(
        'emits [loading, success] for update status on success',
        build: () {
          when(() => mockContactsRepository.updateContact(any())).thenAnswer((_) async {});
          return sut;
        },
        act: (bloc) => bloc.add(ContactUpdateRequested(updatedContact: updatedContact)),
        expect: () => [
          isA<ContactsState>().having((s) => s.updateStatus, 'updateStatus', ContactUpdateStatus.loading),
          isA<ContactsState>().having((s) => s.updateStatus, 'updateStatus', ContactUpdateStatus.success),
        ],
        verify: (_) {
          verify(() => mockContactsRepository.updateContact(updatedContact)).called(1);
        },
      );
    });

    group('Stream Subscription (_ContactsRefreshed)', () {
      blocTest<ContactsBloc, ContactsState>(
        'emits loaded state with new contacts when stream emits',
        build: () => sut,
        act: (bloc) => contactsStreamController.add(testContacts),
        expect: () => [
          isA<ContactsState>()
              .having((s) => s.status, 'status', ContactsStatus.loaded)
              .having((s) => s.contacts, 'contacts', testContacts),
        ],
      );
    });
  });
}

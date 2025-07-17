import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/add_contact/add_contact_bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/usecases/add_contact_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddContactUsecase extends Mock implements AddContactUsecase {}

class FakeAddContactUsecaseParams extends Fake implements AddContactUsecaseParams {}

void main() {
  late AddContactBloc sut;
  late MockAddContactUsecase mockAddContactUsecase;

  final testContact = Contact(name: 'Test Contact', address: '0x123');

  setUpAll(() {
    registerFallbackValue(FakeAddContactUsecaseParams());
  });

  setUp(() {
    mockAddContactUsecase = MockAddContactUsecase();
    sut = AddContactBloc(mockAddContactUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('AddContactBloc', () {
    test('initial state is AddContactInitial', () {
      expect(sut.state, isA<AddContactInitial>());
    });

    blocTest<AddContactBloc, AddContactState>(
      'emits [AddContactLoading, AddContactSuccess] when adding contact is successful',
      build: () {
        when(() => mockAddContactUsecase.execute(any())).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) => bloc.add(AddContactRequested(contact: testContact)),
      expect: () => [
        isA<AddContactLoading>(),
        isA<AddContactSuccess>(),
      ],
      verify: (_) {
        verify(() => mockAddContactUsecase.execute(any(that: isA<AddContactUsecaseParams>()))).called(1);
      },
    );

    blocTest<AddContactBloc, AddContactState>(
      'emits [AddContactLoading, AddContactError] with specific message on DomainException',
      build: () {
        when(() => mockAddContactUsecase.execute(any())).thenThrow(DomainException('Cannot add yourself'));
        return sut;
      },
      act: (bloc) => bloc.add(AddContactRequested(contact: testContact)),
      expect: () => [
        isA<AddContactLoading>(),
        isA<AddContactError>().having((e) => e.message, 'message', 'Cannot add yourself'),
      ],
    );

    blocTest<AddContactBloc, AddContactState>(
      'emits [AddContactLoading, AddContactError] with generic message on other Exceptions',
      build: () {
        when(() => mockAddContactUsecase.execute(any())).thenThrow(Exception('Some other error'));
        return sut;
      },
      act: (bloc) => bloc.add(AddContactRequested(contact: testContact)),
      expect: () => [
        isA<AddContactLoading>(),
        isA<AddContactError>().having((e) => e.message, 'message', 'Unknown error'),
      ],
    );
  });
}

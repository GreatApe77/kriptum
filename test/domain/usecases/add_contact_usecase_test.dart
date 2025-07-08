import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/usecases/add_contact_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_accounts_repository.dart';
import '../../mocks/mock_contacts_repository.dart';

void main() {
  late AddContactUsecase sut;
  late MockContactsRepository mockContactsRepository;
  late MockAccountsRepository mockAccountsRepository;

  setUp(() {
    mockContactsRepository = MockContactsRepository();
    mockAccountsRepository = MockAccountsRepository();

    sut = AddContactUsecase(mockContactsRepository, mockAccountsRepository);
  });
  setUpAll(() {
    registerFallbackValue(Contact(name: '', address: ''));
  });

  group('AddContactUsecase', () {
    final currentUserAccount = Account(
      accountIndex: 0,
      address: '0xUserAddress',
      encryptedJsonWallet: '',
    );

    final newContact = Contact(
      name: 'John Doe',
      address: '0xContactAddress',
    );

    test('should save contact when all conditions are met', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => currentUserAccount);

      when(() => mockContactsRepository.saveContact(any())).thenAnswer((_) async => Future.value());

      final params = AddContactUsecaseParams(contact: newContact);
      await sut.execute(params);

      verify(() => mockContactsRepository.saveContact(newContact)).called(1);
    });

    test('should throw DomainException when current account is null', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => null);

      final params = AddContactUsecaseParams(contact: newContact);
      expect(
        () => sut.execute(params),
        throwsA(isA<DomainException>().having(
          (e) => e.getReason(),
          'reason',
          'Invalid current account state',
        )),
      );

      verifyNever(() => mockContactsRepository.saveContact(any()));
    });

    test('should throw DomainException when trying to add self as a contact', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => currentUserAccount);

      final selfContact = Contact(
        name: 'Myself',
        address: currentUserAccount.address,
      );

      final params = AddContactUsecaseParams(contact: selfContact);
      expect(
        () => sut.execute(params),
        throwsA(isA<DomainException>().having(
          (e) => e.getReason(),
          'reason',
          'Cannot add yourself',
        )),
      );

      verifyNever(() => mockContactsRepository.saveContact(any()));
    });
  });
}

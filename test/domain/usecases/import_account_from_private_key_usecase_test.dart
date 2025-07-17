import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/usecases/import_account_from_private_key_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_account_generator_service.dart';
import '../../mocks/mock_accounts_repository.dart';
import '../../mocks/mock_password_repository.dart';

void main() {
  late ImportAccountFromPrivateKeyUsecase sut;
  late MockPasswordRepository mockPasswordRepository;
  late MockAccountGeneratorService mockAccountGeneratorService;
  late MockAccountsRepository mockAccountsRepository;

  setUp(() {
    mockPasswordRepository = MockPasswordRepository();
    mockAccountGeneratorService = MockAccountGeneratorService();
    mockAccountsRepository = MockAccountsRepository();

    sut = ImportAccountFromPrivateKeyUsecase(
      mockPasswordRepository,
      mockAccountGeneratorService,
      mockAccountsRepository,
    );
  });

  group('ImportAccountFromPrivateKeyUsecase', () {
    const testPassword = 'test_password';
    const testPrivateKey = '0x_private_key';
    final importedAccount = Account(
      accountIndex: 99,
      address: '0xImportedAddress',
      encryptedJsonWallet: 'imported_wallet',
      isImported: true,
    );
    final params = ImportAccountFromPrivateKeyInput(privateKey: testPrivateKey);

    test('should import and save account when it does not already exist', () async {
      when(() => mockPasswordRepository.getPassword()).thenReturn(testPassword);
      when(() => mockAccountGeneratorService.generateAccountFromPrivateKey(
            encryptionPassword: testPassword,
            privateKey: testPrivateKey,
          )).thenAnswer((_) async => importedAccount);

      when(() => mockAccountsRepository.getAccounts()).thenAnswer((_) async => []);
      when(() => mockAccountsRepository.saveAccounts([importedAccount])).thenAnswer((_) async => Future.value());

      await sut.execute(params);

      verify(() => mockAccountsRepository.saveAccounts([importedAccount])).called(1);
    });

    test('should throw DomainException when trying to import an existing account', () async {
      when(() => mockPasswordRepository.getPassword()).thenReturn(testPassword);
      when(() => mockAccountGeneratorService.generateAccountFromPrivateKey(
            encryptionPassword: testPassword,
            privateKey: testPrivateKey,
          )).thenAnswer((_) async => importedAccount);

      when(() => mockAccountsRepository.getAccounts()).thenAnswer((_) async => [importedAccount]);

      expect(
        () => sut.execute(params),
        throwsA(isA<DomainException>().having(
          (e) => e.getReason(),
          'reason',
          'Account already saved',
        )),
      );

      verifyNever(() => mockAccountsRepository.saveAccounts(any()));
    });

    test('should propagate exception if a dependency throws', () async {
      final testException = Exception('Failed to generate account');
      when(() => mockPasswordRepository.getPassword()).thenReturn(testPassword);
      when(() => mockAccountGeneratorService.generateAccountFromPrivateKey(
            encryptionPassword: testPassword,
            privateKey: testPrivateKey,
          )).thenThrow(testException);

      expect(() => sut.execute(params), throwsA(testException));

      verifyNever(() => mockAccountsRepository.getAccounts());
      verifyNever(() => mockAccountsRepository.saveAccounts(any()));
    });
  });
}

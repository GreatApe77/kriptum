import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/exceptions/invalid_current_account_state_exception.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/services/account_decryption_with_password_service.dart';
import 'package:kriptum/domain/usecases/unlock_wallet_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_account_decryption_with_password_service.dart';
import '../../mocks/mock_accounts_repository.dart';
import '../../mocks/mock_password_repository.dart';

class FakeAccountDecryptionParams extends Fake implements AccountDecryptionWithPasswordParams {}

void main() {
  late UnlockWalletUsecase sut;
  late MockAccountsRepository mockAccountsRepository;
  late MockAccountDecryptionWithPasswordService mockAccountDecryptionService;
  late MockPasswordRepository mockPasswordRepository;

  final testAccount = Account(
    accountIndex: 0,
    address: '0xTestAddress',
    encryptedJsonWallet: 'test_wallet_json',
  );
  const correctPassword = 'correct_password';
  const wrongPassword = 'wrong_password';

  setUpAll(() {
    registerFallbackValue(FakeAccountDecryptionParams());
  });

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    mockAccountDecryptionService = MockAccountDecryptionWithPasswordService();
    mockPasswordRepository = MockPasswordRepository();

    sut = UnlockWalletUsecase(
      accountsRepository: mockAccountsRepository,
      accountDecryptionWithPasswordService: mockAccountDecryptionService,
      passwordRepository: mockPasswordRepository,
    );
  });

  group('UnlockWalletUsecase', () {
    test('should set password in repository when password is correct', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockAccountDecryptionService.isPasswordCorrect(any())).thenAnswer((_) async => true);
      when(() => mockPasswordRepository.setPassword(correctPassword)).thenReturn(null);

      await sut.execute(correctPassword);

      verify(() => mockPasswordRepository.setPassword(correctPassword)).called(1);
    });

    test('should send correct password and encrypted wallet to decryption service', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockAccountDecryptionService.isPasswordCorrect(any())).thenAnswer((_) async => true);
      when(() => mockPasswordRepository.setPassword(any())).thenReturn(null);

      await sut.execute(correctPassword);

      final captured = verify(
        () => mockAccountDecryptionService.isPasswordCorrect(captureAny()),
      ).captured.single as AccountDecryptionWithPasswordParams;

      expect(captured.password, correctPassword);
      expect(captured.encryptedAccount, testAccount.encryptedJsonWallet);
    });

    test('should throw WrongPasswordException when password is wrong', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockAccountDecryptionService.isPasswordCorrect(any())).thenAnswer((_) async => false);

      await expectLater(
        sut.execute(wrongPassword),
        throwsA(isA<WrongPasswordException>()),
      );

      verifyNever(() => mockPasswordRepository.setPassword(any()));
    });

    test('should throw exception when no current account is found', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => null);

      await expectLater(
        sut.execute(correctPassword),
        throwsA(isA<InvalidCurrentAccountStateException>()),
      );

      verifyNever(() => mockAccountDecryptionService.isPasswordCorrect(any()));
      verifyNever(() => mockPasswordRepository.setPassword(any()));
    });

    test('should call getCurrentAccount once', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockAccountDecryptionService.isPasswordCorrect(any())).thenAnswer((_) async => true);
      when(() => mockPasswordRepository.setPassword(any())).thenReturn(null);

      await sut.execute(correctPassword);

      verify(() => mockAccountsRepository.getCurrentAccount()).called(1);
    });

    test('should call decryption service once when account exists', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockAccountDecryptionService.isPasswordCorrect(any())).thenAnswer((_) async => true);
      when(() => mockPasswordRepository.setPassword(any())).thenReturn(null);

      await sut.execute(correctPassword);

      verify(() => mockAccountDecryptionService.isPasswordCorrect(any())).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
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
    final testAccount = Account(
      accountIndex: 0,
      address: '0xTestAddress',
      encryptedJsonWallet: 'test_wallet_json',
    );
    const correctPassword = 'correct_password';
    const wrongPassword = 'wrong_password';

    test('should set password in repository when password is correct', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockAccountDecryptionService.isPasswordCorrect(any())).thenAnswer((_) async => true);
      when(() => mockPasswordRepository.setPassword(correctPassword)).thenReturn(null);

      await sut.execute(correctPassword);

      verify(() => mockPasswordRepository.setPassword(correctPassword)).called(1);
    });

    test('should throw exception when password is wrong', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockAccountDecryptionService.isPasswordCorrect(any())).thenAnswer((_) async => false);

      final call = sut.execute;

      expect(() => call(wrongPassword),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message', 'Exception: Wrong password')));
      verifyNever(() => mockPasswordRepository.setPassword(any()));
    });

    test('should throw exception when no current account is found', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => null);

      final call = sut.execute;

      expect(() => call(correctPassword),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message', 'Exception: No current account found')));
      verifyNever(() => mockAccountDecryptionService.isPasswordCorrect(any()));
      verifyNever(() => mockPasswordRepository.setPassword(any()));
    });
  });
}

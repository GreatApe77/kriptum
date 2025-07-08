import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/models/account.dart';

import 'package:kriptum/domain/usecases/confirm_and_save_generated_accounts_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_accounts_repository.dart';
import '../../mocks/mock_encryption_service.dart';
import '../../mocks/mock_mnemonic_repository.dart';
import '../../mocks/mock_password_repository.dart';

void main() {
  late ConfirmAndSaveGeneratedAccountsUsecase sut;
  late MockAccountsRepository mockAccountsRepository;
  late MockEncryptionService mockEncryptionService;
  late MockMnemonicRepository mockMnemonicRepository;
  late MockPasswordRepository mockPasswordRepository;

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    mockEncryptionService = MockEncryptionService();
    mockMnemonicRepository = MockMnemonicRepository();
    mockPasswordRepository = MockPasswordRepository();
    sut = ConfirmAndSaveGeneratedAccountsUsecase(
      accountsRepository: mockAccountsRepository,
      encryptionService: mockEncryptionService,
      mnemonicRepository: mockMnemonicRepository,
      passwordRepository: mockPasswordRepository,
    );
  });

  group('ConfirmAndSaveGeneratedAccountsUsecase', () {
    final testAccounts = [
      Account(accountIndex: 0, address: '0x123', encryptedJsonWallet: 'wallet1'),
      Account(accountIndex: 1, address: '0x456', encryptedJsonWallet: 'wallet2'),
    ];
    const testMnemonic = 'test mnemonic phrase';
    const testPassword = 'test_password';
    const encryptedMnemonic = 'encrypted_mnemonic_string';

    test('should encrypt mnemonic, save accounts, and store encrypted mnemonic', () async {
      when(() => mockPasswordRepository.getPassword()).thenReturn(testPassword);

      when(() => mockEncryptionService.encrypt(data: testMnemonic, password: testPassword))
          .thenReturn(encryptedMnemonic);
      when(() => mockAccountsRepository.saveAccounts(testAccounts)).thenAnswer((_) async => Future.value());
      when(() => mockMnemonicRepository.storeEncryptedMnemonic(encryptedMnemonic))
          .thenAnswer((_) async => Future.value());

      await sut.execute(testAccounts, testMnemonic);

      verify(() => mockPasswordRepository.getPassword()).called(1);
      verify(() => mockEncryptionService.encrypt(data: testMnemonic, password: testPassword)).called(1);
      verify(() => mockAccountsRepository.saveAccounts(testAccounts)).called(1);
      verify(() => mockMnemonicRepository.storeEncryptedMnemonic(encryptedMnemonic)).called(1);
    });

    test('should propagate exception if any dependency throws', () async {
      final testException = Exception('Failed to save accounts');
      when(() => mockPasswordRepository.getPassword()).thenReturn(testPassword);
      when(() => mockEncryptionService.encrypt(data: testMnemonic, password: testPassword))
          .thenReturn(encryptedMnemonic);
      when(() => mockAccountsRepository.saveAccounts(testAccounts)).thenThrow(testException);

      expect(() => sut.execute(testAccounts, testMnemonic), throwsA(testException));

      verifyNever(() => mockMnemonicRepository.storeEncryptedMnemonic(any()));
    });
  });
}

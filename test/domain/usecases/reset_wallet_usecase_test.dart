import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/usecases/reset_wallet_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_accounts_repository.dart';
import '../../mocks/mock_contacts_repository.dart';
import '../../mocks/mock_mnemonic_repository.dart';

void main() {
  late ResetWalletUsecase sut;
  late MockAccountsRepository mockAccountsRepository;
  late MockMnemonicRepository mockMnemonicRepository;
  late MockContactsRepository mockContactsRepository;

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    mockMnemonicRepository = MockMnemonicRepository();
    mockContactsRepository = MockContactsRepository();

    sut = ResetWalletUsecase(
      accountsRepository: mockAccountsRepository,
      mnemonicRepository: mockMnemonicRepository,
      contactsRepository: mockContactsRepository,
    );
  });

  group('ResetWalletUsecase', () {
    void arrangeSuccess() {
      when(() => mockAccountsRepository.changeCurrentAccount(null)).thenAnswer((_) async {});
      when(() => mockAccountsRepository.deleteAllAccounts()).thenAnswer((_) async {});
      when(() => mockMnemonicRepository.storeEncryptedMnemonic('')).thenAnswer((_) async {});
      when(() => mockContactsRepository.deleteAllContacts()).thenAnswer((_) async {});
    }

    test('should call all repository methods to clear wallet data', () async {
      arrangeSuccess();

      await sut.execute();

      verifyInOrder([
        () => mockAccountsRepository.changeCurrentAccount(null),
        () => mockAccountsRepository.deleteAllAccounts(),
        () => mockMnemonicRepository.storeEncryptedMnemonic(''),
        () => mockContactsRepository.deleteAllContacts(),
      ]);
    });

    test('should propagate exception and stop execution if a repository throws', () async {
      final testException = Exception('Database connection lost');
      when(() => mockAccountsRepository.changeCurrentAccount(null)).thenAnswer((_) async {});
      when(() => mockAccountsRepository.deleteAllAccounts()).thenThrow(testException);
      when(() => mockMnemonicRepository.storeEncryptedMnemonic('')).thenAnswer((_) async {});
      when(() => mockContactsRepository.deleteAllContacts()).thenAnswer((_) async {});

      expect(() => sut.execute(), throwsA(testException));

      verify(() => mockAccountsRepository.changeCurrentAccount(null)).called(1);
      verifyNever(() => mockAccountsRepository.deleteAllAccounts());
      verifyNever(() => mockMnemonicRepository.storeEncryptedMnemonic(''));
      verifyNever(() => mockContactsRepository.deleteAllContacts());
    });
  });
}

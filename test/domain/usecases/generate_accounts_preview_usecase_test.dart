import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';
import 'package:kriptum/domain/usecases/generate_accounts_preview_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_account_generator_service.dart';

void main() {
  late GenerateAccountsPreviewUsecase sut;
  late MockAccountGeneratorService mockAccountGeneratorService;

  setUpAll(
    () {
      registerFallbackValue(AccountsFromMnemonicParams(
          mnemonic: 'mnemonic', encryptionPassword: 'encryptionPassword'));
    },
  );
  setUp(() {
    mockAccountGeneratorService = MockAccountGeneratorService();
    sut = GenerateAccountsPreviewUsecase(
      accountGenerator: mockAccountGeneratorService,
    );
  });
  test('Should generate 20 accounts', () async {
    // Arrange
    final params = GenerateAccountsPreviewUsecaseParams(
      password: 'test_password',
      mnemonic: 'test_mnemonic',
    );
    when(
      () => mockAccountGeneratorService.generateAccounts(
        any<AccountsFromMnemonicParams>(),
      ),
    ).thenAnswer(
      (_) async => List.generate(
        20,
        (index) => Account(
          accountIndex: index,
          address: '',
          encryptedJsonWallet: '',
          alias: '',
          isImported: false,
        ),
      ),
    );

    // Act
    final accounts = await sut.execute(params);

    // Assert
    expect(accounts.length, 20);
  });
}

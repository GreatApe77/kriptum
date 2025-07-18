import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/factories/mnemonic_factory.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/mnemonic.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';
import 'package:kriptum/domain/usecases/import_wallet_usecase.dart';
import 'package:kriptum/shared/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_accounts_repository.dart';
import '../../mocks/mock_encryption_service.dart';
import '../../mocks/mock_mnemonic_repository.dart';
import '../../mocks/mock_password_repository.dart';

class MockAccountGeneratorService extends Mock implements AccountGeneratorService {}

class MockMnemonicFactory extends Mock implements MnemonicFactory {}

void main() {
  late ImportWalletUsecase sut;
  late MockAccountGeneratorService mockAccountGeneratorService;
  late MockAccountsRepository mockAccountsRepository;
  late MockMnemonicFactory mockMnemonicFactory;
  late MockEncryptionService mockEncryptionService;
  late MockPasswordRepository mockPasswordRepository;
  late MockMnemonicRepository mockMnemonicRepository;
  final sampleAccount = Account(
    accountIndex: 0,
    address: '',
    encryptedJsonWallet: '',
  );
  setUpAll(() {
    registerFallbackValue(
      AccountsFromMnemonicParams(encryptionPassword: '', mnemonic: ''),
    );
  });
  setUp(
    () {
      mockAccountGeneratorService = MockAccountGeneratorService();
      mockMnemonicFactory = MockMnemonicFactory();
      mockAccountsRepository = MockAccountsRepository();
      mockMnemonicRepository = MockMnemonicRepository();
      mockPasswordRepository = MockPasswordRepository();
      mockEncryptionService = MockEncryptionService();

      sut = ImportWalletUsecase(
        mockAccountGeneratorService,
        mockAccountsRepository,
        mockMnemonicFactory,
        mockPasswordRepository,
        mockEncryptionService,
        mockMnemonicRepository,
      );
    },
  );
  test(
    'Should throw an exception when Mnemonic is not valid',
    () async {
      when(
        () => mockMnemonicFactory.create(
          any(),
        ),
      ).thenReturn(
        Result.failure('It is not valid'),
      );
      final params = ImportWalletUsecaseParams(
        mnemonic: '',
        encryptionPassword: '',
      );
      await expectLater(sut.execute(params), throwsA(isA<Exception>()));
    },
  );
  test(
    'Should successfully import wallet',
    () async {
      when(
        () => mockMnemonicFactory.create(
          any(),
        ),
      ).thenReturn(
        Result.success(
          Mnemonic('test test test test test test test test test test test junk'),
        ),
      );
      when(
        () => mockEncryptionService.encrypt(
          data: any(named: 'data'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) => '',
      );
      final mockReturnList = List<Account>.generate(
        20,
        (index) => sampleAccount,
      );
      when(
        () => mockAccountGeneratorService.generateAccounts(any()),
      ).thenAnswer(
        (_) async => mockReturnList,
      );
      when(
        () => mockAccountsRepository.saveAccounts(any()),
      ).thenAnswer((invocation) async {});
      when(
        () => mockMnemonicRepository.storeEncryptedMnemonic(any()),
      ).thenAnswer(
        (_) async => {},
      );
      final params = ImportWalletUsecaseParams(
        mnemonic: '',
        encryptionPassword: '',
      );

      await sut.execute(params);

      verify(
        () => mockAccountsRepository.saveAccounts(mockReturnList),
      );
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/create_new_wallet/create_new_wallet_bloc.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';
import 'package:kriptum/domain/usecases/confirm_and_save_generated_accounts_usecase.dart';
import 'package:kriptum/domain/usecases/generate_accounts_preview_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGenerateAccountsPreviewUsecase extends Mock implements GenerateAccountsPreviewUsecase {}

class MockConfirmAndSaveGeneratedAccountsUsecase extends Mock implements ConfirmAndSaveGeneratedAccountsUsecase {}

class MockAccountGeneratorService extends Mock implements AccountGeneratorService {}

class FakeGenerateAccountsPreviewUsecaseParams extends Fake implements GenerateAccountsPreviewUsecaseParams {}

void main() {
  late CreateNewWalletBloc sut;
  late MockGenerateAccountsPreviewUsecase mockGenerateAccountsPreviewUsecase;
  late MockConfirmAndSaveGeneratedAccountsUsecase mockConfirmAndSaveGeneratedAccountsUsecase;
  late MockAccountGeneratorService mockAccountGeneratorService;

  final testAccounts = [Account(accountIndex: 0, address: '0x123', encryptedJsonWallet: 'wallet1')];
  const testMnemonic = 'test mnemonic phrase';
  const testPassword = 'password123';

  setUpAll(() {
    registerFallbackValue(FakeGenerateAccountsPreviewUsecaseParams());
  });

  setUp(() {
    mockGenerateAccountsPreviewUsecase = MockGenerateAccountsPreviewUsecase();
    mockConfirmAndSaveGeneratedAccountsUsecase = MockConfirmAndSaveGeneratedAccountsUsecase();
    mockAccountGeneratorService = MockAccountGeneratorService();
    sut = CreateNewWalletBloc(
      generateAccountsPreviewUsecase: mockGenerateAccountsPreviewUsecase,
      confirmAndSaveGeneratedAccountsUsecase: mockConfirmAndSaveGeneratedAccountsUsecase,
      accountGeneratorService: mockAccountGeneratorService,
    );
  });

  tearDown(() {
    sut.close();
  });

  group('CreateNewWalletBloc', () {
    test('initial state is correct', () {
      expect(sut.state.step, CreateNewWalletState.initial().step);
    });

    blocTest<CreateNewWalletBloc, CreateNewWalletState>(
      'emits state with updated password on PasswordChangedEvent',
      build: () => sut,
      act: (bloc) => bloc.add(PasswordChangedEvent(password: testPassword)),
      expect: () => [
        isA<CreateNewWalletState>().having((s) => s.password, 'password', testPassword),
      ],
    );

    blocTest<CreateNewWalletBloc, CreateNewWalletState>(
      'emits state with updated confirmPassword on ConfirmPasswordChangedEvent',
      build: () => sut,
      act: (bloc) => bloc.add(ConfirmPasswordChangedEvent(confirmPassword: testPassword)),
      expect: () => [
        isA<CreateNewWalletState>().having((s) => s.confirmPassword, 'confirmPassword', testPassword),
      ],
    );

    group('AdvanceToStep2Event', () {
      blocTest<CreateNewWalletBloc, CreateNewWalletState>(
        'emits failure when passwords do not match',
        build: () => sut,
        seed: () => CreateNewWalletState.initial().copyWith(password: 'a', confirmPassword: 'b'),
        act: (bloc) => bloc.add(AdvanceToStep2Event()),
        expect: () => [
          isA<CreateNewWalletState>()
              .having((s) => s.status, 'status', CreateNewWalletStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'Passwords do not match or are empty.'),
        ],
      );

      blocTest<CreateNewWalletBloc, CreateNewWalletState>(
        'emits [loading, success] and advances to step 2 on success',
        build: () {
          when(() => mockAccountGeneratorService.generateMnemonic()).thenReturn(testMnemonic);
          when(() => mockGenerateAccountsPreviewUsecase.execute(any())).thenAnswer((_) async => testAccounts);
          return sut;
        },
        seed: () => CreateNewWalletState.initial().copyWith(password: testPassword, confirmPassword: testPassword),
        act: (bloc) => bloc.add(AdvanceToStep2Event()),
        expect: () => [
          isA<CreateNewWalletState>().having((s) => s.status, 'status', CreateNewWalletStatus.loading),
          isA<CreateNewWalletState>()
              .having((s) => s.status, 'status', CreateNewWalletStatus.success)
              .having((s) => s.step, 'step', 2)
              .having((s) => s.mnemonic, 'mnemonic', testMnemonic)
              .having((s) => s.accounts, 'accounts', testAccounts),
        ],
      );
    });

    blocTest<CreateNewWalletBloc, CreateNewWalletState>(
      'emits state with step 3 on AdvanceToStep3Event',
      build: () => sut,
      seed: () => CreateNewWalletState.initial().copyWith(step: 2),
      act: (bloc) => bloc.add(AdvanceToStep3Event()),
      expect: () => [
        isA<CreateNewWalletState>().having((s) => s.step, 'step', 3),
      ],
    );

    group('ConfirmBackupEvent', () {
      blocTest<CreateNewWalletBloc, CreateNewWalletState>(
        'emits [loading, success] on successful save',
        build: () {
          when(() => mockConfirmAndSaveGeneratedAccountsUsecase.execute(any(), any())).thenAnswer((_) async {});
          return sut;
        },
        seed: () => CreateNewWalletState.initial().copyWith(accounts: testAccounts, mnemonic: testMnemonic),
        act: (bloc) => bloc.add(ConfirmBackupEvent()),
        expect: () => [
          isA<CreateNewWalletState>().having((s) => s.status, 'status', CreateNewWalletStatus.loading),
          isA<CreateNewWalletState>().having((s) => s.status, 'status', CreateNewWalletStatus.success),
        ],
        verify: (_) {
          verify(() => mockConfirmAndSaveGeneratedAccountsUsecase.execute(testAccounts, testMnemonic)).called(1);
        },
      );

      blocTest<CreateNewWalletBloc, CreateNewWalletState>(
        'emits [loading, failure] when saving fails',
        build: () {
          when(() => mockConfirmAndSaveGeneratedAccountsUsecase.execute(any(), any()))
              .thenThrow(Exception('DB error'));
          return sut;
        },
        seed: () => CreateNewWalletState.initial().copyWith(accounts: testAccounts, mnemonic: testMnemonic),
        act: (bloc) => bloc.add(ConfirmBackupEvent()),
        expect: () => [
          isA<CreateNewWalletState>().having((s) => s.status, 'status', CreateNewWalletStatus.loading),
          isA<CreateNewWalletState>()
              .having((s) => s.status, 'status', CreateNewWalletStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', contains('Failed to save accounts')),
        ],
      );
    });
  });
}

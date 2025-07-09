import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/current_account/current_account_cubit.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements AccountsRepository {}

class FakeAccount extends Fake implements Account {}

void main() {
  late CurrentAccountCubit sut;
  late MockAccountsRepository mockAccountsRepository;
  late StreamController<Account?> accountStreamController;

  final testAccount = Account(
    accountIndex: 0,
    address: '0xTestAddress',
    encryptedJsonWallet: 'test_wallet',
  );

  setUpAll(() {
    registerFallbackValue(FakeAccount());
  });

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    accountStreamController = StreamController<Account?>.broadcast();
    when(() => mockAccountsRepository.currentAccountStream()).thenAnswer((_) => accountStreamController.stream);
    sut = CurrentAccountCubit(mockAccountsRepository);
  });

  tearDown(() {
    accountStreamController.close();
    sut.close();
  });

  group('CurrentAccountCubit', () {
    test('initial state is correct', () {
      expect(sut.state, isA<CurrentAccountState>());
      expect(sut.state.account, isNull);
    });

    group('requestCurrentAccount', () {
      blocTest<CurrentAccountCubit, CurrentAccountState>(
        'emits state with account on success',
        build: () {
          when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
          return sut;
        },
        act: (cubit) => cubit.requestCurrentAccount(),
        expect: () => [
          isA<CurrentAccountState>().having((s) => s.account, 'account', testAccount),
        ],
        verify: (_) {
          verify(() => mockAccountsRepository.getCurrentAccount()).called(1);
        },
      );

      blocTest<CurrentAccountCubit, CurrentAccountState>(
        'emits state with null account on failure',
        build: () {
          when(() => mockAccountsRepository.getCurrentAccount()).thenThrow(Exception('Failed to load'));
          return sut;
        },
        act: (cubit) => cubit.requestCurrentAccount(),
        expect: () => [
          isA<CurrentAccountState>().having((s) => s.account, 'account', isNull),
        ],
        verify: (_) {
          verify(() => mockAccountsRepository.getCurrentAccount()).called(1);
        },
      );
    });

    group('changeCurrentAccount', () {
      blocTest<CurrentAccountCubit, CurrentAccountState>(
        'calls repository and does not emit state directly on success',
        build: () {
          when(() => mockAccountsRepository.changeCurrentAccount(any())).thenAnswer((_) async {});
          return sut;
        },
        act: (cubit) => cubit.changeCurrentAccount(testAccount),
        expect: () => [],
        verify: (_) {
          verify(() => mockAccountsRepository.changeCurrentAccount(testAccount)).called(1);
        },
      );

      blocTest<CurrentAccountCubit, CurrentAccountState>(
        'emits state with null account on failure',
        build: () {
          when(() => mockAccountsRepository.changeCurrentAccount(any())).thenThrow(Exception('Failed to change'));
          return sut;
        },
        act: (cubit) => cubit.changeCurrentAccount(testAccount),
        expect: () => [
          isA<CurrentAccountState>().having((s) => s.account, 'account', isNull),
        ],
        verify: (_) {
          verify(() => mockAccountsRepository.changeCurrentAccount(testAccount)).called(1);
        },
      );
    });

    group('Stream Subscription', () {
      blocTest<CurrentAccountCubit, CurrentAccountState>(
        'emits new state when account stream emits a new account',
        build: () => sut,
        act: (cubit) => accountStreamController.add(testAccount),
        expect: () => [
          isA<CurrentAccountState>().having((s) => s.account, 'account', testAccount),
        ],
      );

      blocTest<CurrentAccountCubit, CurrentAccountState>(
        'emits new state with null when account stream emits null',
        build: () => sut,
        act: (cubit) => accountStreamController.add(null),
        expect: () => [
          isA<CurrentAccountState>().having((s) => s.account, 'account', isNull),
        ],
      );
    });
  });
}

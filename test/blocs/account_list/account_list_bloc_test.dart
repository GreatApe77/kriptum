import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/account_list/account_list_bloc.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements AccountsRepository {}

class FakeAccount extends Fake implements Account {}

void main() {
  late AccountListBloc sut;
  late MockAccountsRepository mockAccountsRepository;
  late StreamController<List<Account>> accountsStreamController;

  final testAccounts = [
    Account(accountIndex: 0, address: '0x1', encryptedJsonWallet: 'wallet1'),
    Account(accountIndex: 1, address: '0x2', encryptedJsonWallet: 'wallet2'),
  ];

  setUpAll(() {
    registerFallbackValue(FakeAccount());
  });

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    accountsStreamController = StreamController<List<Account>>.broadcast();
    when(() => mockAccountsRepository.watchAccounts()).thenAnswer((_) => accountsStreamController.stream);
    sut = AccountListBloc(mockAccountsRepository);
  });

  tearDown(() {
    accountsStreamController.close();
    sut.close();
  });

  group('AccountListBloc', () {
    test('initial state is correct', () {
      expect(sut.state, isA<AccountListState>());
      expect(sut.state.accounts, isEmpty);
    });

    group('AccountListRequested', () {
      blocTest<AccountListBloc, AccountListState>(
        'emits state with accounts on success',
        build: () {
          when(() => mockAccountsRepository.getAccounts()).thenAnswer((_) async => testAccounts);
          return sut;
        },
        act: (bloc) => bloc.add(AccountListRequested()),
        expect: () => [
          isA<AccountListState>().having((s) => s.accounts, 'accounts', testAccounts),
        ],
        verify: (_) {
          verify(() => mockAccountsRepository.getAccounts()).called(1);
        },
      );

      blocTest<AccountListBloc, AccountListState>(
        'emits state with empty accounts list on failure',
        build: () {
          when(() => mockAccountsRepository.getAccounts()).thenThrow(Exception('Failed to load'));
          return sut;
        },
        act: (bloc) => bloc.add(AccountListRequested()),
        expect: () => [
          isA<AccountListState>().having((s) => s.accounts, 'accounts', []),
        ],
      );
    });

    group('AccountsListUpdated', () {
      final updatedAccount =
          Account(accountIndex: 0, address: '0x1', encryptedJsonWallet: 'wallet1_updated', alias: 'Updated');

      blocTest<AccountListBloc, AccountListState>(
        'calls updateAccount and expects no new state directly',
        build: () {
          when(() => mockAccountsRepository.updateAccount(any())).thenAnswer((_) async {});
          return sut;
        },
        act: (bloc) => bloc.add(AccountsListUpdated(updatedAccount: updatedAccount)),
        expect: () => [],
        verify: (_) {
          verify(() => mockAccountsRepository.updateAccount(updatedAccount)).called(1);
        },
      );

      blocTest<AccountListBloc, AccountListState>(
        'emits state with error message on failure',
        build: () {
          when(() => mockAccountsRepository.updateAccount(any())).thenThrow(Exception('Update failed'));
          return sut;
        },
        act: (bloc) => bloc.add(AccountsListUpdated(updatedAccount: updatedAccount)),
        expect: () => [
          isA<AccountListState>().having((s) => s.errorMessage, 'errorMessage', 'Failed to update account.'),
        ],
      );
    });

    group('Stream Subscription (_AccountsListRefreshed)', () {
      blocTest<AccountListBloc, AccountListState>(
        'emits new state with accounts when stream emits',
        build: () => sut,
        act: (bloc) => accountsStreamController.add(testAccounts),
        expect: () => [
          isA<AccountListState>().having((s) => s.accounts, 'accounts', testAccounts),
        ],
      );
    });
  });
}

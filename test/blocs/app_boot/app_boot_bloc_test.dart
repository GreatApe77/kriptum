import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/app_boot/app_boot_bloc.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements AccountsRepository {}

void main() {
  late AppBootBloc sut;
  late MockAccountsRepository mockAccountsRepository;

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    sut = AppBootBloc(accountsRepository: mockAccountsRepository);
  });

  tearDown(() {
    sut.close();
  });

  group('AppBootBloc', () {
    test('initial state has unknown status', () {
      expect(sut.state.appBootStatus, AppBootStatus.unknown);
    });

    blocTest<AppBootBloc, AppBootState>(
      'emits [noWallet] when no accounts are found',
      build: () {
        when(() => mockAccountsRepository.getAccounts()).thenAnswer((_) async => []);
        return sut;
      },
      act: (bloc) => bloc.add(AppBootStarted()),
      expect: () => [
        isA<AppBootState>().having((s) => s.appBootStatus, 'status', AppBootStatus.noWallet),
      ],
      verify: (_) {
        verify(() => mockAccountsRepository.getAccounts()).called(1);
      },
    );

    blocTest<AppBootBloc, AppBootState>(
      'emits [lockedWallet] when accounts are found',
      build: () {
        final accounts = [Account(accountIndex: 0, address: '0x123', encryptedJsonWallet: 'wallet1')];
        when(() => mockAccountsRepository.getAccounts()).thenAnswer((_) async => accounts);
        return sut;
      },
      act: (bloc) => bloc.add(AppBootStarted()),
      expect: () => [
        isA<AppBootState>().having((s) => s.appBootStatus, 'status', AppBootStatus.lockedWallet),
      ],
      verify: (_) {
        verify(() => mockAccountsRepository.getAccounts()).called(1);
      },
    );
  });
}

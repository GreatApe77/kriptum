import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/lock_wallet/lock_wallet_bloc.dart';
import 'package:kriptum/domain/usecases/lock_wallet_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockLockWalletUsecase extends Mock implements LockWalletUsecase {}

void main() {
  late LockWalletBloc sut;
  late MockLockWalletUsecase mockLockWalletUsecase;

  setUp(() {
    mockLockWalletUsecase = MockLockWalletUsecase();
    sut = LockWalletBloc(mockLockWalletUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('LockWalletBloc', () {
    test('initial state is LockWalletInitial', () {
      expect(sut.state, isA<LockWalletInitial>());
    });

    blocTest<LockWalletBloc, LockWalletState>(
      'emits [LockWalletSuccess] when locking wallet is successful',
      build: () {
        when(() => mockLockWalletUsecase.execute()).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) => bloc.add(LockWalletRequested()),
      expect: () => [
        isA<LockWalletSuccess>(),
      ],
      verify: (_) {
        verify(() => mockLockWalletUsecase.execute()).called(1);
      },
    );

    blocTest<LockWalletBloc, LockWalletState>(
      'emits [LockWalletError] when locking wallet fails',
      build: () {
        when(() => mockLockWalletUsecase.execute()).thenThrow(Exception('Failed to lock'));
        return sut;
      },
      act: (bloc) => bloc.add(LockWalletRequested()),
      expect: () => [
        isA<LockWalletError>().having(
          (e) => e.errorMessage,
          'errorMessage',
          'Could not Lock Wallet',
        ),
      ],
      verify: (_) {
        verify(() => mockLockWalletUsecase.execute()).called(1);
      },
    );
  });
}

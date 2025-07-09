import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/unlock_wallet/unlock_wallet_bloc.dart';
import 'package:kriptum/domain/usecases/unlock_wallet_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUnlockWalletUsecase extends Mock implements UnlockWalletUsecase {}

void main() {
  late MockUnlockWalletUsecase mockUnlockWalletUsecase;

  setUp(() {
    mockUnlockWalletUsecase = MockUnlockWalletUsecase();
  });

  group('UnlockWalletBloc', () {
    const password = 'test_password';

    test('initial state is UnlockWalletInitial', () {
      expect(
        UnlockWalletBloc(unlockWalletUsecase: mockUnlockWalletUsecase).state,
        isA<UnlockWalletInitial>(),
      );
    });

    blocTest<UnlockWalletBloc, UnlockWalletState>(
      'emits [UnlockWalletInProgress, UnlockWalletSuccess] when unlock is successful',
      build: () {
        when(() => mockUnlockWalletUsecase.execute(any())).thenAnswer((_) async {});
        return UnlockWalletBloc(unlockWalletUsecase: mockUnlockWalletUsecase);
      },
      act: (bloc) => bloc.add(UnlockWalletRequested(password)),
      expect: () => [
        isA<UnlockWalletInProgress>(),
        isA<UnlockWalletSuccess>(),
      ],
      verify: (_) {
        verify(() => mockUnlockWalletUsecase.execute(password)).called(1);
      },
    );

    blocTest<UnlockWalletBloc, UnlockWalletState>(
      'emits [UnlockWalletInProgress, UnlockWalletFailure] when unlock fails',
      build: () {
        when(() => mockUnlockWalletUsecase.execute(any())).thenThrow(Exception('Failed to unlock'));
        return UnlockWalletBloc(unlockWalletUsecase: mockUnlockWalletUsecase);
      },
      act: (bloc) => bloc.add(UnlockWalletRequested(password)),
      expect: () => [
        isA<UnlockWalletInProgress>(),
        isA<UnlockWalletFailure>(),
      ],
      verify: (_) {
        verify(() => mockUnlockWalletUsecase.execute(password)).called(1);
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/reset_wallet/reset_wallet_bloc.dart';
import 'package:kriptum/domain/usecases/reset_wallet_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockResetWalletUsecase extends Mock implements ResetWalletUsecase {}

void main() {
  late ResetWalletBloc sut;
  late MockResetWalletUsecase mockResetWalletUsecase;

  setUp(() {
    mockResetWalletUsecase = MockResetWalletUsecase();
    sut = ResetWalletBloc(resetWalletUsecase: mockResetWalletUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('ResetWalletBloc', () {
    test('initial state is ResetWalletInitial', () {
      expect(sut.state, isA<ResetWalletInitial>());
    });

    blocTest<ResetWalletBloc, ResetWalletState>(
      'emits [ResetWalletInProgress, ResetWalletSuccess] when reset is successful',
      build: () {
        when(() => mockResetWalletUsecase.execute()).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) => bloc.add(ResetWalletRequested()),
      expect: () => [
        isA<ResetWalletInProgress>(),
        isA<ResetWalletSuccess>(),
      ],
      verify: (_) {
        verify(() => mockResetWalletUsecase.execute()).called(1);
      },
    );

    blocTest<ResetWalletBloc, ResetWalletState>(
      'emits [ResetWalletInProgress, ResetWalletFailure] when reset fails',
      build: () {
        when(() => mockResetWalletUsecase.execute()).thenThrow(Exception('Failed to reset'));
        return sut;
      },
      act: (bloc) => bloc.add(ResetWalletRequested()),
      expect: () => [
        isA<ResetWalletInProgress>(),
        isA<ResetWalletFailure>(),
      ],
      verify: (_) {
        verify(() => mockResetWalletUsecase.execute()).called(1);
      },
    );
  });
}

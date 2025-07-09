import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/add_hd_wallet_account/add_hd_wallet_account_bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/usecases/add_hd_wallet_account_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddHdWalletAccountUsecase extends Mock implements AddHdWalletAccountUsecase {}

void main() {
  late AddHdWalletAccountBloc sut;
  late MockAddHdWalletAccountUsecase mockAddHdWalletAccountUsecase;

  setUp(() {
    mockAddHdWalletAccountUsecase = MockAddHdWalletAccountUsecase();
    sut = AddHdWalletAccountBloc(mockAddHdWalletAccountUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('AddHdWalletAccountBloc', () {
    test('initial state is AddHdWalletAccountInitial', () {
      expect(sut.state, isA<AddHdWalletAccountInitial>());
    });

    blocTest<AddHdWalletAccountBloc, AddHdWalletAccountState>(
      'emits [AddHdWalletAccountLoading, AddHdWalletAccountSuccess] when usecase succeeds',
      build: () {
        when(() => mockAddHdWalletAccountUsecase.execute()).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) => bloc.add(AddHdWalletAccountRequested()),
      expect: () => [
        isA<AddHdWalletAccountLoading>(),
        isA<AddHdWalletAccountSuccess>(),
      ],
      verify: (_) {
        verify(() => mockAddHdWalletAccountUsecase.execute()).called(1);
      },
    );

    blocTest<AddHdWalletAccountBloc, AddHdWalletAccountState>(
      'emits [AddHdWalletAccountLoading, AddHdWalletAccountError] with specific message on DomainException',
      build: () {
        when(() => mockAddHdWalletAccountUsecase.execute()).thenThrow(DomainException('Invalid password'));
        return sut;
      },
      act: (bloc) => bloc.add(AddHdWalletAccountRequested()),
      expect: () => [
        isA<AddHdWalletAccountLoading>(),
        isA<AddHdWalletAccountError>().having((e) => e.message, 'message', 'Invalid password'),
      ],
      verify: (_) {
        verify(() => mockAddHdWalletAccountUsecase.execute()).called(1);
      },
    );

    blocTest<AddHdWalletAccountBloc, AddHdWalletAccountState>(
      'emits [AddHdWalletAccountLoading, AddHdWalletAccountError] with generic message on other Exceptions',
      build: () {
        when(() => mockAddHdWalletAccountUsecase.execute()).thenThrow(Exception('Some other error'));
        return sut;
      },
      act: (bloc) => bloc.add(AddHdWalletAccountRequested()),
      expect: () => [
        isA<AddHdWalletAccountLoading>(),
        isA<AddHdWalletAccountError>().having((e) => e.message, 'message', 'Could not add Wallet'),
      ],
      verify: (_) {
        verify(() => mockAddHdWalletAccountUsecase.execute()).called(1);
      },
    );
  });
}

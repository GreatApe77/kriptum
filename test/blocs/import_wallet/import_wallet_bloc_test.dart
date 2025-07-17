import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/import_wallet/import_wallet_bloc.dart';
import 'package:kriptum/domain/usecases/import_wallet_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockImportWalletUsecase extends Mock implements ImportWalletUsecase {}

class FakeImportWalletUsecaseParams extends Fake implements ImportWalletUsecaseParams {}

void main() {
  late ImportWalletBloc sut;
  late MockImportWalletUsecase mockImportWalletUsecase;

  setUpAll(() {
    registerFallbackValue(FakeImportWalletUsecaseParams());
  });

  setUp(() {
    mockImportWalletUsecase = MockImportWalletUsecase();
    sut = ImportWalletBloc(mockImportWalletUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('ImportWalletBloc', () {
    const mnemonicPhrase = 'test mnemonic phrase';
    const password = 'test_password';

    test('initial state is ImportWalletInitial', () {
      expect(sut.state, isA<ImportWalletInitial>());
    });

    blocTest<ImportWalletBloc, ImportWalletState>(
      'emits [ImportWalletLoading, ImportWalletSuccess] when import is successful',
      build: () {
        when(() => mockImportWalletUsecase.execute(any())).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) => bloc.add(ImportWalletRequested(mnemonicPhrase: mnemonicPhrase, password: password)),
      expect: () => [
        isA<ImportWalletLoading>(),
        isA<ImportWalletSuccess>(),
      ],
      verify: (_) {
        verify(() => mockImportWalletUsecase.execute(any(that: isA<ImportWalletUsecaseParams>()))).called(1);
      },
    );

    blocTest<ImportWalletBloc, ImportWalletState>(
      'emits [ImportWalletLoading, ImportWalletFailed] when import fails',
      build: () {
        when(() => mockImportWalletUsecase.execute(any())).thenThrow(Exception('Failed to import'));
        return sut;
      },
      act: (bloc) => bloc.add(ImportWalletRequested(mnemonicPhrase: mnemonicPhrase, password: password)),
      expect: () => [
        isA<ImportWalletLoading>(),
        isA<ImportWalletFailed>().having((e) => e.reason, 'reason', 'Failed to import Wallet'),
      ],
      verify: (_) {
        verify(() => mockImportWalletUsecase.execute(any(that: isA<ImportWalletUsecaseParams>()))).called(1);
      },
    );
  });
}

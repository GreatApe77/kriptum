import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/import_account/import_account_bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/usecases/import_account_from_private_key_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockImportAccountFromPrivateKeyUsecase extends Mock implements ImportAccountFromPrivateKeyUsecase {}

class FakeImportAccountFromPrivateKeyInput extends Fake implements ImportAccountFromPrivateKeyInput {}

void main() {
  late ImportAccountBloc sut;
  late MockImportAccountFromPrivateKeyUsecase mockImportAccountFromPrivateKeyUsecase;

  setUpAll(() {
    registerFallbackValue(FakeImportAccountFromPrivateKeyInput());
  });

  setUp(() {
    mockImportAccountFromPrivateKeyUsecase = MockImportAccountFromPrivateKeyUsecase();
    sut = ImportAccountBloc(mockImportAccountFromPrivateKeyUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('ImportAccountBloc', () {
    const privateKey = '0x_test_private_key';

    test('initial state is ImportAccountInitial', () {
      expect(sut.state, isA<ImportAccountInitial>());
    });

    blocTest<ImportAccountBloc, ImportAccountState>(
      'emits [ImportAccountLoading, ImportAccountSuccess] when import is successful',
      build: () {
        when(() => mockImportAccountFromPrivateKeyUsecase.execute(any())).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) => bloc.add(ImportAccountRequested(privateKey: privateKey)),
      expect: () => [
        isA<ImportAccountLoading>(),
        isA<ImportAccountSuccess>(),
      ],
      verify: (_) {
        verify(() => mockImportAccountFromPrivateKeyUsecase.execute(any(that: isA<ImportAccountFromPrivateKeyInput>())))
            .called(1);
      },
    );

    blocTest<ImportAccountBloc, ImportAccountState>(
      'emits [ImportAccountLoading, ImportAccountFailed] with specific message on DomainException',
      build: () {
        when(() => mockImportAccountFromPrivateKeyUsecase.execute(any()))
            .thenThrow(DomainException('Account already exists'));
        return sut;
      },
      act: (bloc) => bloc.add(ImportAccountRequested(privateKey: privateKey)),
      expect: () => [
        isA<ImportAccountLoading>(),
        isA<ImportAccountFailed>().having((e) => e.errorMessage, 'errorMessage', 'Account already exists'),
      ],
    );

    blocTest<ImportAccountBloc, ImportAccountState>(
      'emits [ImportAccountLoading, ImportAccountFailed] with generic message on other Exceptions',
      build: () {
        when(() => mockImportAccountFromPrivateKeyUsecase.execute(any())).thenThrow(Exception('Some other error'));
        return sut;
      },
      act: (bloc) => bloc.add(ImportAccountRequested(privateKey: privateKey)),
      expect: () => [
        isA<ImportAccountLoading>(),
        isA<ImportAccountFailed>().having((e) => e.errorMessage, 'errorMessage', 'Failed to Import Account'),
      ],
    );
  });
}

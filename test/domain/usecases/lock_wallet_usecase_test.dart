import 'package:flutter_test/flutter_test.dart';

import 'package:kriptum/domain/usecases/lock_wallet_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_accounts_repository.dart';
import '../../mocks/mock_password_repository.dart';

void main() {
  // Declare the variables that will be used in the tests
  late LockWalletUsecase sut; // System Under Test
  late MockAccountsRepository mockAccountsRepository;
  late MockPasswordRepository mockPasswordRepository;

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    mockPasswordRepository = MockPasswordRepository();

    sut = LockWalletUsecase(mockAccountsRepository, mockPasswordRepository);
  });

  group('LockWalletUsecase', () {
    test('should clear password and set current account to null', () async {
      when(() => mockPasswordRepository.setPassword('')).thenReturn(null);

      when(() => mockAccountsRepository.changeCurrentAccount(null)).thenAnswer((_) async => Future.value());

      await sut.execute();

      verify(() => mockPasswordRepository.setPassword('')).called(1);
      verify(() => mockAccountsRepository.changeCurrentAccount(null)).called(1);
    });

    test('should propagate exception if a dependency throws', () async {
      final testException = Exception('Failed to change account');
      when(() => mockPasswordRepository.setPassword('')).thenReturn(null);
      when(() => mockAccountsRepository.changeCurrentAccount(null)).thenThrow(testException);

      expect(() => sut.execute(), throwsA(testException));

      verify(() => mockPasswordRepository.setPassword('')).called(1);
    });
  });
}

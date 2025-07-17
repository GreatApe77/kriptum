import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/factories/ethereum_address/ethereum_address.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_ethereum_address_validator.dart';

void main() {
  late EthereumAddressFactory sut; // System Under Test
  late MockEthereumAddressValidator mockEthereumAddressValidator;

  setUp(() {
    mockEthereumAddressValidator = MockEthereumAddressValidator();
    sut = EthereumAddressFactory(mockEthereumAddressValidator);
  });

  group('EthereumAddressFactory', () {
    test('should return failure when address is empty', () {
      final result = sut.create('');
      expect(result.isSuccess, false);
      expect(result.failure, 'Address cannot be empty');
    });

    test('should return failure when address does not start with 0x', () {
      final result = sut.create('123abcDEF');
      expect(result.isSuccess, false);
      expect(result.failure, 'Address must start with 0x');
    });

    test('should return failure when validator returns an error message', () {
      const invalidAddress = '0x123invalid';
      const errorMessage = 'Invalid checksum';
      when(
        () => mockEthereumAddressValidator.validateWithReason(invalidAddress),
      ).thenReturn(errorMessage);
      //mockEthereumAddressValidator.(errorMessage);

      final result = sut.create(invalidAddress);
      expect(result.isSuccess, false);
      expect(result.failure, errorMessage);
    });

    test('should return success when address is valid', () {
      const validAddress = '0x742d35Cc6634C0532925a3b844Bc454e4438f444';
      //mockEthereumAddressValidator.mockValidationResult(null); // Validator says it's valid
      when(
        () => mockEthereumAddressValidator.validateWithReason(validAddress),
      ).thenReturn(null);
      final result = sut.create(validAddress);
      expect(result.isSuccess, true);
      expect(result.value, isA<EthereumAddressVO>());
      expect(result.value?.value, validAddress);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/factories/ethereum_address/ethereum_address.dart';
import 'package:kriptum/domain/models/erc20_token.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/erc20_token_repository.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/domain/usecases/import_erc20_token_usecase.dart';
import 'package:kriptum/shared/utils/result.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworksRepository extends Mock implements NetworksRepository {}

class MockErc20TokenRepository extends Mock implements Erc20TokenRepository {}

class MockEthereumAddressFactory extends Mock implements EthereumAddressFactory {}

class FakeErc20Token extends Fake implements Erc20Token {}

class FakeEthereumAddressVO extends Fake implements EthereumAddressVO {
  @override
  final String value;

  FakeEthereumAddressVO(this.value);
}

void main() {
  late ImportErc20TokenUsecase sut;
  late MockNetworksRepository mockNetworksRepository;
  late MockErc20TokenRepository mockErc20tokenRepository;
  late MockEthereumAddressFactory mockEthereumAddressFactory;

  final validInput = ImportErc20TokenInput(
    name: 'Test Token',
    symbol: 'TST',
    decimals: 18,
    contractAddress: '0x1234567890123456789012345678901234567890',
  );

  final testNetwork = Network(id: 1, name: 'Testnet', rpcUrl: '', ticker: 'ETH', currencyDecimals: 18);

  setUpAll(() {
    registerFallbackValue(FakeErc20Token());
  });

  setUp(() {
    mockNetworksRepository = MockNetworksRepository();
    mockErc20tokenRepository = MockErc20TokenRepository();
    mockEthereumAddressFactory = MockEthereumAddressFactory();

    sut = ImportErc20TokenUsecase(
      mockNetworksRepository,
      mockErc20tokenRepository,
      mockEthereumAddressFactory,
    );
  });

  group('ImportErc20TokenUsecase', () {
    test('should save token when all inputs are valid and token does not exist', () async {
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(
        Result.success(FakeEthereumAddressVO(validInput.contractAddress)),
      );
      when(() => mockNetworksRepository.getCurrentNetwork()).thenAnswer((_) async => testNetwork);
      when(() => mockErc20tokenRepository.findByAddress(any())).thenAnswer((_) async => null);
      when(() => mockErc20tokenRepository.save(any())).thenAnswer((_) async {});

      await sut.execute(validInput);

      verify(() => mockErc20tokenRepository.save(any(that: isA<Erc20Token>()))).called(1);
    });

    test('should throw DomainException if address validation fails', () {
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(Result.failure('Invalid address'));

      expect(
        () => sut.execute(validInput),
        throwsA(isA<DomainException>().having((e) => e.getReason(), 'reason', 'Invalid address')),
      );
      verifyNever(() => mockErc20tokenRepository.save(any()));
    });

    test('should throw DomainException if token already exists', () {
      final existingToken = Erc20Token(
        address: validInput.contractAddress,
        name: validInput.name,
        symbol: validInput.symbol,
        decimals: validInput.decimals,
        networkId: testNetwork.id!,
      );
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(
        Result.success(FakeEthereumAddressVO(validInput.contractAddress)),
      );
      when(() => mockNetworksRepository.getCurrentNetwork()).thenAnswer((_) async => testNetwork);
      when(() => mockErc20tokenRepository.findByAddress(any())).thenAnswer((_) async => existingToken);

      expect(
        () => sut.execute(validInput),
        throwsA(isA<DomainException>().having((e) => e.getReason(), 'reason', 'Token already imported')),
      );
      verifyNever(() => mockErc20tokenRepository.save(any()));
    });

    test('should throw DomainException if token name is invalid', () {
      final invalidInput = ImportErc20TokenInput(
        name: 'This token name is definitely way too long to be valid',
        symbol: 'TST',
        decimals: 18,
        contractAddress: validInput.contractAddress,
      );
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(
        Result.success(FakeEthereumAddressVO(validInput.contractAddress)),
      );

      expect(
        () => sut.execute(invalidInput),
        throwsA(isA<DomainException>().having((e) => e.getReason(), 'reason', 'Token name must be lower or equal to 20 chars')),
      );
      verifyNever(() => mockErc20tokenRepository.save(any()));
    });

    test('should throw DomainException if token symbol is invalid', () {
      final invalidInput = ImportErc20TokenInput(
        name: 'Test Token',
        symbol: 'INVALID-SYMBOL-TOO-LONG',
        decimals: 18,
        contractAddress: validInput.contractAddress,
      );
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(
        Result.success(FakeEthereumAddressVO(validInput.contractAddress)),
      );

      expect(
        () => sut.execute(invalidInput),
        throwsA(isA<DomainException>().having((e) => e.getReason(), 'reason', 'Symbol must be lower or equal to 10 chars')),
      );
      verifyNever(() => mockErc20tokenRepository.save(any()));
    });

    test('should throw DomainException if token decimals are invalid', () {
      final invalidInput = ImportErc20TokenInput(
        name: 'Test Token',
        symbol: 'TST',
        decimals: -1,
        contractAddress: validInput.contractAddress,
      );
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(
        Result.success(FakeEthereumAddressVO(validInput.contractAddress)),
      );

      expect(
        () => sut.execute(invalidInput),
        throwsA(isA<DomainException>().having((e) => e.getReason(), 'reason', 'Cannot be negative')),
      );
      verifyNever(() => mockErc20tokenRepository.save(any()));
    });
  });
}

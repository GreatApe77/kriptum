import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/factories/ethereum_address/ethereum_address.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/domain/services/erc20_token_service.dart';
import 'package:kriptum/domain/usecases/search_erc20_token_metadata_usecase.dart';
import 'package:kriptum/shared/utils/result.dart';
import 'package:mocktail/mocktail.dart';

class MockErc20TokenService extends Mock implements Erc20TokenService {}

class MockNetworksRepository extends Mock implements NetworksRepository {}

class MockEthereumAddressFactory extends Mock implements EthereumAddressFactory {}

class FakeEthereumAddressVO extends Fake implements EthereumAddressVO {
  @override
  final String value;
  FakeEthereumAddressVO(this.value);
}

void main() {
  late SearchErc20TokenMetadataUsecase sut;
  late MockErc20TokenService mockErc20TokenService;
  late MockNetworksRepository mockNetworksRepository;
  late MockEthereumAddressFactory mockEthereumAddressFactory;

  final testInput = SearchErc20TokenMetadataInput(
    contractAddress: '0x1234567890123456789012345678901234567890',
  );

  final testNetwork = Network(id: 1, name: 'Testnet', rpcUrl: 'http://test.rpc', ticker: 'ETH', currencyDecimals: 18);

  setUp(() {
    mockErc20TokenService = MockErc20TokenService();
    mockNetworksRepository = MockNetworksRepository();
    mockEthereumAddressFactory = MockEthereumAddressFactory();

    sut = SearchErc20TokenMetadataUsecase(
      mockErc20TokenService,
      mockNetworksRepository,
      mockEthereumAddressFactory,
    );
  });

  group('SearchErc20TokenMetadataUsecase', () {
    test('should return token metadata on successful fetch', () async {
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(
        Result.success(FakeEthereumAddressVO(testInput.contractAddress)),
      );
      when(() => mockNetworksRepository.getCurrentNetwork()).thenAnswer((_) async => testNetwork);
      when(() => mockErc20TokenService.getName(address: any(named: 'address'), rpcUrl: any(named: 'rpcUrl')))
          .thenAnswer((_) async => 'Test Token');
      when(() => mockErc20TokenService.getSymbol(address: any(named: 'address'), rpcUrl: any(named: 'rpcUrl')))
          .thenAnswer((_) async => 'TST');
      when(() => mockErc20TokenService.getDecimals(address: any(named: 'address'), rpcUrl: any(named: 'rpcUrl')))
          .thenAnswer((_) async => 18);

      final result = await sut.execute(testInput);

      expect(result.name, 'Test Token');
      expect(result.symbol, 'TST');
      expect(result.decimals, 18);

      verify(() => mockErc20TokenService.getName(address: testInput.contractAddress, rpcUrl: testNetwork.rpcUrl)).called(1);
      verify(() => mockErc20TokenService.getSymbol(address: testInput.contractAddress, rpcUrl: testNetwork.rpcUrl)).called(1);
      verify(() => mockErc20TokenService.getDecimals(address: testInput.contractAddress, rpcUrl: testNetwork.rpcUrl)).called(1);
    });

    test('should throw DomainException if address validation fails', () {
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(Result.failure('Invalid address'));

      expect(
        () => sut.execute(testInput),
        throwsA(isA<DomainException>().having((e) => e.getReason(), 'reason', 'Invalid address')),
      );

      verifyNever(() => mockNetworksRepository.getCurrentNetwork());
      verifyNever(() => mockErc20TokenService.getName(address: any(named: 'address'), rpcUrl: any(named: 'rpcUrl')));
    });

    test('should propagate exception if token service fails', () {
      final testException = Exception('RPC Error');
      when(() => mockEthereumAddressFactory.create(any())).thenReturn(
        Result.success(FakeEthereumAddressVO(testInput.contractAddress)),
      );
      when(() => mockNetworksRepository.getCurrentNetwork()).thenAnswer((_) async => testNetwork);
      when(() => mockErc20TokenService.getName(address: any(named: 'address'), rpcUrl: any(named: 'rpcUrl')))
          .thenThrow(testException);
      when(() => mockErc20TokenService.getSymbol(address: any(named: 'address'), rpcUrl: any(named: 'rpcUrl')))
          .thenAnswer((_) async => 'TST');
      when(() => mockErc20TokenService.getDecimals(address: any(named: 'address'), rpcUrl: any(named: 'rpcUrl')))
          .thenAnswer((_) async => 18);

      expect(() => sut.execute(testInput), throwsA(testException));
    });
  });
}

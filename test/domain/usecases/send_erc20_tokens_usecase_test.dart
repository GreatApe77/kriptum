import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/repositories.dart';
import 'package:kriptum/domain/services/erc20_token_service.dart';
import 'package:kriptum/domain/usecases/send_erc20_tokens_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements AccountsRepository {}

class MockNetworksRepository extends Mock implements NetworksRepository {}

class MockPasswordRepository extends Mock implements PasswordRepository {}

class MockErc20TokenService extends Mock implements Erc20TokenService {}

class FakeSendErc20TokensInput extends Fake implements SendErc20TokensInput {}

void main() {
  late SendErc20TokensUsecase sut;
  late MockAccountsRepository mockAccountsRepository;
  late MockNetworksRepository mockNetworksRepository;
  late MockPasswordRepository mockPasswordRepository;
  late MockErc20TokenService mockErc20TokenService;

  final testAccount = Account(accountIndex: 0, address: '0xFromAddress', encryptedJsonWallet: 'encrypted_wallet');
  final testNetwork = Network(id: 1, name: 'Testnet', rpcUrl: 'http://test.rpc', ticker: 'ETH', currencyDecimals: 18);
  const testPassword = 'test_password';
  const testTxHash = '0x_transaction_hash';
  final testInput = SendErc20TokensInput(
    erc20TokenAddress: '0xTokenAddress',
    toAddress: '0xToAddress',
    amount: BigInt.from(100),
  );

  setUpAll(() {
    registerFallbackValue(FakeSendErc20TokensInput());
    registerFallbackValue(BigInt.zero);
  });

  setUp(() {
    mockAccountsRepository = MockAccountsRepository();
    mockNetworksRepository = MockNetworksRepository();
    mockPasswordRepository = MockPasswordRepository();
    mockErc20TokenService = MockErc20TokenService();

    sut = SendErc20TokensUsecase(
      mockAccountsRepository,
      mockNetworksRepository,
      mockPasswordRepository,
      mockErc20TokenService,
    );
  });

  group('SendErc20TokensUsecase', () {
    test('should return transaction hash on successful transfer', () async {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockNetworksRepository.getCurrentNetwork()).thenAnswer((_) async => testNetwork);
      when(() => mockPasswordRepository.getPassword()).thenReturn(testPassword);
      when(() => mockErc20TokenService.transfer(
            contractAddress: any(named: 'contractAddress'),
            amount: any(named: 'amount'),
            rpcUrl: any(named: 'rpcUrl'),
            encryptedWallet: any(named: 'encryptedWallet'),
            decryptionPassword: any(named: 'decryptionPassword'),
            toAddress: any(named: 'toAddress'),
          )).thenAnswer((_) async => testTxHash);

      final result = await sut.execute(testInput);

      expect(result, testTxHash);
      verify(() => mockErc20TokenService.transfer(
            contractAddress: testInput.erc20TokenAddress,
            amount: testInput.amount,
            rpcUrl: testNetwork.rpcUrl,
            encryptedWallet: testAccount.encryptedJsonWallet,
            decryptionPassword: testPassword,
            toAddress: testInput.toAddress,
          )).called(1);
    });

    test('should throw DomainException if no current account is found', () {
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => null);

      expect(
        () => sut.execute(testInput),
        throwsA(isA<DomainException>().having((e) => e.getReason(), 'reason', 'Invalid account state')),
      );
      verifyNever(() => mockErc20TokenService.transfer(
            contractAddress: any(named: 'contractAddress'),
            amount: any(named: 'amount'),
            rpcUrl: any(named: 'rpcUrl'),
            encryptedWallet: any(named: 'encryptedWallet'),
            decryptionPassword: any(named: 'decryptionPassword'),
            toAddress: any(named: 'toAddress'),
          ));
    });

    test('should propagate exception if token service fails', () {
      final testException = Exception('RPC Error');
      when(() => mockAccountsRepository.getCurrentAccount()).thenAnswer((_) async => testAccount);
      when(() => mockNetworksRepository.getCurrentNetwork()).thenAnswer((_) async => testNetwork);
      when(() => mockPasswordRepository.getPassword()).thenReturn(testPassword);
      when(() => mockErc20TokenService.transfer(
            contractAddress: any(named: 'contractAddress'),
            amount: any(named: 'amount'),
            rpcUrl: any(named: 'rpcUrl'),
            encryptedWallet: any(named: 'encryptedWallet'),
            decryptionPassword: any(named: 'decryptionPassword'),
            toAddress: any(named: 'toAddress'),
          )).thenThrow(testException);

      expect(() => sut.execute(testInput), throwsA(testException));
    });
  });
}

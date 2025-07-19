import 'package:kriptum/domain/services/erc20_token_service.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class Erc20TokenServiceImpl implements Erc20TokenService {
  final http.Client _httpClient;

  Erc20TokenServiceImpl({required http.Client httpClient}) : _httpClient = httpClient;

  static const String _erc20Abi = '''
  [
    {
      "constant": true,
      "inputs": [],
      "name": "name",
      "outputs": [{"name": "", "type": "string"}],
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "symbol",
      "outputs": [{"name": "", "type": "string"}],
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "decimals",
      "outputs": [{"name": "", "type": "uint8"}],
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {"name": "to", "type": "address"},
        {"name": "value", "type": "uint256"}
      ],
      "name": "transfer",
      "outputs": [{"name": "", "type": "bool"}],
      "type": "function"
    }
  ]
  ''';

  Future<T?> _callFunction<T>({
    required String address,
    required String rpcUrl,
    required String functionName,
  }) async {
    try {
      final web3 = Web3Client(rpcUrl, _httpClient);
      final contract = DeployedContract(
        ContractAbi.fromJson(_erc20Abi, 'ERC20'),
        EthereumAddress.fromHex(address),
      );
      final function = contract.function(functionName);
      final result = await web3.call(
        contract: contract,
        function: function,
        params: [],
      );

      if (result.isNotEmpty) {
        return result.first as T;
      }
    } catch (e) {
      print('Error calling $functionName: $e');
    }
    return null;
  }

  @override
  Future<int?> getDecimals({required String address, required String rpcUrl}) async {
    final result = await _callFunction<BigInt>(
      address: address,
      rpcUrl: rpcUrl,
      functionName: 'decimals',
    );
    return result?.toInt();
  }

  @override
  Future<String?> getName({required String address, required String rpcUrl}) {
    return _callFunction<String>(
      address: address,
      rpcUrl: rpcUrl,
      functionName: 'name',
    );
  }

  @override
  Future<String?> getSymbol({required String address, required String rpcUrl}) {
    return _callFunction<String>(
      address: address,
      rpcUrl: rpcUrl,
      functionName: 'symbol',
    );
  }

  @override
  Future<String> transfer({
    required String contractAddress,
    required BigInt amount,
    required String rpcUrl,
    required String encryptedWallet,
    required String decryptionPassword,
    required String toAddress,
  }) async {
    final web3Client = Web3Client(rpcUrl, _httpClient);
    final wallet = Wallet.fromJson(encryptedWallet, decryptionPassword);
    final abi = ContractAbi.fromJson(_erc20Abi, 'ERC20');
    final contractAddressHex = EthereumAddress.fromHex(contractAddress);
    final recipientAddress = EthereumAddress.fromHex(toAddress);
    final contract = DeployedContract(
      abi,
      contractAddressHex,
    );
    final function = contract.function('transfer');
    final transaction = Transaction.callContract(
      contract: contract,
      function: function,
      parameters: [recipientAddress, amount],
    );

    final transactionHash = await web3Client.sendTransaction(wallet.privateKey, transaction);

    return transactionHash;
  }
}

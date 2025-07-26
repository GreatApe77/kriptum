import 'package:http/http.dart' as http;

import 'package:kriptum/infra/network/web3_client.dart';
import 'package:web3dart/web3dart.dart' as web3;

class Web3DartClientImpl implements Web3Client {
  final http.Client httpClient;

  Web3DartClientImpl(this.httpClient);
  @override
  Future<List<dynamic>> call({
    required String contractAddress,
    required String functionName,
    required List params,
    required String rpcUrl,
    required String abiJson,
  }) async {
    final client = web3.Web3Client(rpcUrl, httpClient);
    final contract = web3.DeployedContract(
      web3.ContractAbi.fromJson(abiJson, 'Contract'),
      web3.EthereumAddress.fromHex(contractAddress),
    );
    final function = contract.function(functionName);
    final result = await client.call(
      contract: contract,
      function: function,
      params: params,
    );
    return result;
  }

  @override
  Future<String> sendTransaction({
    required String contractAddress,
    required String functionName,
    required List params,
    required String rpcUrl,
    required String encryptedWallet,
    required String decryptionPassword,
    required String abiJson,
  }) async {
    final client = web3.Web3Client(rpcUrl, httpClient);
    final credentials = web3.Wallet.fromJson(
      encryptedWallet,
      decryptionPassword,
    );
    final contract = web3.DeployedContract(
      web3.ContractAbi.fromJson(abiJson, 'Contract'),
      web3.EthereumAddress.fromHex(contractAddress),
    );
    final function = contract.function(functionName);
    final transaction = web3.Transaction.callContract(
      contract: contract,
      function: function,
      parameters: params,
    );
    final txHash = await client.sendTransaction(
      credentials.privateKey,
      transaction,
      fetchChainIdFromNetworkId: true,
    );
    return txHash;
  }
}

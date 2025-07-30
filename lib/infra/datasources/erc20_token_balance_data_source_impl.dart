import 'package:kriptum/domain/models/ether_amount.dart';

import 'package:kriptum/infra/datasources/data_sources.dart';
import 'package:kriptum/infra/network/web3_client.dart';

class Erc20TokenBalanceDataSourceImpl implements Erc20TokenBalanceDataSource {
  final Web3Client _web3client;
  static const String _erc20Abi = '''
  [
    {"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"}
  ]
  ''';
  Erc20TokenBalanceDataSourceImpl(this._web3client);

  @override
  Future<EtherAmount> getErc20BalanceOfAccount({
    required String accountAddress,
    required String contractAddress,
    required String networkRpcUrl,
  }) async {
    final callResult = await _web3client.callContract(
      contractAddress: contractAddress,
      functionName: "balanceOf",
      params: [accountAddress],
      rpcUrl: networkRpcUrl,
      abiJson: _erc20Abi,
    );
    final balanceInWei = callResult.first as BigInt;
    return EtherAmount(valueInWei: balanceInWei);
  }
}

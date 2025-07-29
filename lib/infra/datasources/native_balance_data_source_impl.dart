import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/infra/datasources/data_sources.dart';
import 'package:kriptum/infra/network/web3_client.dart';

class NativeBalanceDataSourceImpl implements NativeBalanceDataSource {
  final Web3Client _web3client;
  NativeBalanceDataSourceImpl(this._web3client);
  @override
  Future<EtherAmount> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  }) async {
    final balance = await _web3client.getBalance(
      address: accountAddress,
      rpcUrl: network.rpcUrl,
    );
    return EtherAmount(valueInWei: balance);
  }
}

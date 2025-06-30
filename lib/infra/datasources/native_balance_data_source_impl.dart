import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:http/http.dart' as http;
import 'package:kriptum/infra/datasources/native_balance_data_source.dart';
import 'package:web3dart/web3dart.dart' as web3;

class NativeBalanceDataSourceImpl implements NativeBalanceDataSource {
  final http.Client _httpClient;
  NativeBalanceDataSourceImpl(this._httpClient);
  @override
  Future<EtherAmount> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  }) async {
    final web3Client = web3.Web3Client(network.rpcUrl, _httpClient);
    final balance = await web3Client.getBalance(web3.EthereumAddress.fromHex(accountAddress));
    return EtherAmount(
      valueInWei: balance.getInWei,
    );
  }
}

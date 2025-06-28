import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:http/http.dart' as http;
import 'package:kriptum/infra/datasources/native_balance_data_source.dart';
import 'package:web3dart/web3dart.dart';

class NativeBalanceDataSourceImpl implements NativeBalanceDataSource {
  final http.Client _httpClient;
  NativeBalanceDataSourceImpl(this._httpClient);
  @override
  Future<AccountBalance> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  }) async {
    final web3Client = Web3Client(network.rpcUrl, _httpClient);
    final balance = await web3Client.getBalance(EthereumAddress.fromHex(accountAddress));
    return AccountBalance(
      valueInWei: balance.getInWei,
    );
  }
}

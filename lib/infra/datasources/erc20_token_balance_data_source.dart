import 'package:kriptum/domain/models/ether_amount.dart';

abstract interface class Erc20TokenBalanceDataSource {
  Future<EtherAmount> getErc20BalanceOfAccount({
    required String accountAddress,
    required String contractAddress,
    required String networkRpcUrl,
  });
}

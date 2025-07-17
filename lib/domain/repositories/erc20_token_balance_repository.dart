import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/models/network.dart';

abstract interface class Erc20TokenBalanceRepository {
  Future<EtherAmount> getBalance({
    required String erc20ContractAddress,
    required String accountAddress,
    required Network network,
  });
}

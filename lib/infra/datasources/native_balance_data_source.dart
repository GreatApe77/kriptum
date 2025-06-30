import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/models/network.dart';

abstract interface class NativeBalanceDataSource {
  Future<EtherAmount> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  });
}

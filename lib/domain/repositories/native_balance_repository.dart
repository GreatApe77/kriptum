import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/models/network.dart';

abstract interface class NativeBalanceRepository {
  Future<EtherAmount> getNativeBalanceOfAccount(
      {required String accountAddress, required Network network, bool invalidateCache});
}

import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/models/network.dart';

abstract interface class NativeBalanceRepository {
  Future<AccountBalance> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
    bool invalidateCache
  });
}

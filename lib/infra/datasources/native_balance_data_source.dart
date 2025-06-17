import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/models/network.dart';

abstract interface class NativeBalanceDataSource {
  Future<AccountBalance> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  });
}

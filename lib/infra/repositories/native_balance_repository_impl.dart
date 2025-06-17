import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/native_balance_repository.dart';
import 'package:kriptum/infra/datasources/native_balance_data_source.dart';

class NativeBalanceRepositoryImpl implements NativeBalanceRepository {
  final NativeBalanceDataSource _nativeBalanceDataSource;

  NativeBalanceRepositoryImpl(this._nativeBalanceDataSource);

  @override
  Future<AccountBalance> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  }) async {
    return await _nativeBalanceDataSource.getNativeBalanceOfAccount(
      accountAddress: accountAddress,
      network: network,
    );
  }
}

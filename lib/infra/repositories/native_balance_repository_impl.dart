import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/native_balance_repository.dart';
import 'package:kriptum/infra/caching/cache.dart';
import 'package:kriptum/infra/datasources/native_balance_data_source.dart';

class NativeBalanceRepositoryImpl implements NativeBalanceRepository {
  final NativeBalanceDataSource _nativeBalanceDataSource;
  final Cache _cache;
  NativeBalanceRepositoryImpl(this._nativeBalanceDataSource, this._cache);

  @override
  Future<AccountBalance> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  }) async {
    final cachedBalance = _cache.get<AccountBalance>(_buildCacheKey(network.id.toString(), accountAddress));
    if (cachedBalance != null) return cachedBalance;

    final balance = await _nativeBalanceDataSource.getNativeBalanceOfAccount(
      accountAddress: accountAddress,
      network: network,
    );
    _cache.store(_buildCacheKey(network.id.toString(), accountAddress), balance);
    return balance;
  }

  String _buildCacheKey(String networkId, String accountAddress) {
    return '${accountAddress}_$networkId';
  }
}

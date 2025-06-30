import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/native_balance_repository.dart';
import 'package:kriptum/infra/caching/cache.dart';
import 'package:kriptum/infra/datasources/native_balance_data_source.dart';

class NativeBalanceRepositoryImpl implements NativeBalanceRepository {
  final NativeBalanceDataSource _nativeBalanceDataSource;
  final Cache _cache;
  NativeBalanceRepositoryImpl(this._nativeBalanceDataSource, this._cache);

  @override
  Future<EtherAmount> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
    bool invalidateCache = false,
  }) async {
    final cacheKey = _buildCacheKey(network.id.toString(), accountAddress);
    if (invalidateCache) {
      _cache.remove(cacheKey);
    }
    final cachedBalance = _cache.get<EtherAmount>(cacheKey);
    if (cachedBalance != null) return cachedBalance;

    final balance = await _nativeBalanceDataSource.getNativeBalanceOfAccount(
      accountAddress: accountAddress,
      network: network,
    );
    _cache.store(cacheKey, balance);
    return balance;
  }

  String _buildCacheKey(String networkId, String accountAddress) {
    return '${accountAddress}_$networkId';
  }
}

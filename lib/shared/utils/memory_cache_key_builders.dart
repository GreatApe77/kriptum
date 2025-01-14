abstract class MemoryCacheKeyBuilders {
  String buildKeyForAccountBalanceCache(
      {required String accountAddress, required String networkId}) {
    return '$accountAddress-$networkId';
  }
}

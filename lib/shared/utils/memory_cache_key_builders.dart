abstract class MemoryCacheKeyBuilders {
  static String buildKeyForAccountBalanceCache(
      {required String accountAddress, required String networkId}) {
    return '$accountAddress-$networkId';
  }
}

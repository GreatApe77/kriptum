class MemoryCache {
  static final Map<String, dynamic> _cacheHashMap = {};

  static void store<V>(String key, V value,
      {Duration duration = const Duration(seconds: 5)}) {
    _cacheHashMap[key] = value;
    Future.delayed(
      duration,
      () {
        _cacheHashMap[key] = null;
      },
    );
  }

  static V? get<V>(String key) {
    return _cacheHashMap[key] as V?;
  }
}

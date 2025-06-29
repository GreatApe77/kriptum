
import 'package:kriptum/infra/caching/cache.dart';

class MemoryCache implements Cache {
  final Map<String, dynamic> _cacheHashMap = {};

  @override
  void store<V>(String key, V value,
      {Duration duration = const Duration(seconds: 5)}) {
    _cacheHashMap[key] = value;
    Future.delayed(
      duration,
      () {
        remove(key);
      },
    );
  }

  @override
  void clearCache() {
    _cacheHashMap.clear();
  }

  @override
  void remove(String key) {
    _cacheHashMap.remove(key);
  }

  @override
  V? get<V>(String key) {
    return _cacheHashMap[key] as V?;
  }
}
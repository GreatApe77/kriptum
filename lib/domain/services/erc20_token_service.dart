abstract interface class Erc20TokenService {
  Future<String?> getName({
    required String address,
    required String rpcUrl,
  });
  Future<String?> getSymbol({
    required String address,
    required String rpcUrl,
  });
  Future<int?> getDecimals({
    required String address,
    required String rpcUrl,
  });
}

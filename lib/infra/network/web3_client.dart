abstract interface class Web3Client {
  Future<List<dynamic>> call({
    required String contractAddress,
    required String functionName,
    required List<dynamic> params,
    required String rpcUrl,
    required String abiJson,
  });
  Future<String> sendTransaction({
    required String contractAddress,
    required String functionName,
    required List<dynamic> params,
    required String rpcUrl,
    required String encryptedWallet,
    required String decryptionPassword,
    required String abiJson,
  });
}

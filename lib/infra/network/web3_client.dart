abstract interface class Web3Client {
  Future<List<dynamic>> callContract({
    required String contractAddress,
    required String functionName,
    required List<dynamic> params,
    required String rpcUrl,
    required String abiJson,
  });
  Future<String> sendContractTransaction({
    required String contractAddress,
    required String functionName,
    required List<dynamic> params,
    required String rpcUrl,
    required String encryptedWallet,
    required String decryptionPassword,
    required String abiJson,
  });

  Future<BigInt> getBalance({
    required String address,
    required String rpcUrl,
  });
}

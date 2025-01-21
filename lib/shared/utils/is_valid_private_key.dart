bool isValidEthereumPrivateKey(String privateKey) {
  if (privateKey.startsWith('0x')) {
    privateKey = privateKey.substring(2);
  }
  final privateKeyPattern = RegExp(r'^[0-9a-fA-F]{64}$');
  return privateKeyPattern.hasMatch(privateKey);
}

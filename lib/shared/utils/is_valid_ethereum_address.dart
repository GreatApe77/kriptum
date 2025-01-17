bool isValidEthereumAddress(String ethAddress) {
  if (ethAddress.length == 42 && ethAddress.startsWith('0x')) {
    final hexPattern = RegExp(r'^[0-9a-fA-F]{40}$');
    return hexPattern.hasMatch(ethAddress.substring(2));
  }
  return false;
}
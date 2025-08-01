BigInt convertStringEthToWei(String ethAmount) {
  if (ethAmount.contains(',')) {
    ethAmount = ethAmount.replaceAll(',', '.');
  }
  if (ethAmount.startsWith('.')) {
    throw ArgumentError('Cannot start with .');
  }
  BigInt weiPerEth = BigInt.from(10).pow(18); // 1 ETH = 10^18 wei
  List<String> parts = ethAmount.split('.');
  BigInt wholePart = BigInt.parse(parts[0]) * weiPerEth;
  BigInt fractionalPart = BigInt.zero;

  if (parts.length > 1 && parts[1].isNotEmpty) {
    String fractionalString = parts[1].padRight(18, '0').substring(0, 18);
    fractionalPart = BigInt.parse(fractionalString);
  }
  return wholePart + fractionalPart;
}

abstract interface class EthereumAddressValidator {
  /// Returns null if ethAddress is valid. Returns a Error message otherwise
  String? validateWithReason(String ethAddress);
}

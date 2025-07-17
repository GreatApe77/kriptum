part of "ethereum_address.dart";

class EthereumAddressFactory implements Factory<String, EthereumAddressVO, String> {
  final EthereumAddressValidator _ethereumAddressValidator;

  EthereumAddressFactory(this._ethereumAddressValidator);

  @override
  Result<EthereumAddressVO, String> create(String address) {
    if (address.isEmpty) {
      return Result.failure('Address cannot be empty');
    }
    if (!address.startsWith('0x')) {
      return Result.failure('Address must start with 0x');
    }
    final validationErrorMessage = _ethereumAddressValidator.validateWithReason(address);
    if (validationErrorMessage != null) {
      return Result.failure(validationErrorMessage);
    }
    return Result.success(EthereumAddressVO._fromValidated(address));
  }
}

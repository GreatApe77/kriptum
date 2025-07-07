part of 'ethereum_address.dart';
class EthereumAddressVO {
  final String value;
  const EthereumAddressVO._(this.value);
  
  factory EthereumAddressVO._fromValidated(String value){
    return EthereumAddressVO._(value);
  }
  /*EthereumAddress(this.value) {
    final reason = _validateWithReason(value);
    if (reason != null) {
      throw ArgumentError(reason);
    }
  }

  String? _validateWithReason(String value) {
    if (value.isEmpty) {
      return 'Ethereum address cannot be empty';
    }
    if (!RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value)) {
      return 'Invalid Ethereum address format';
    }
    return null;
  }*/
}

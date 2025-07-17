import 'dart:math';

class EtherAmount {
  final BigInt _valueInWei;
  final int _decimals;
  EtherAmount({
    required BigInt valueInWei,
    int decimals = 18,
  })  : _valueInWei = valueInWei,
        _decimals = decimals;

  factory EtherAmount.fromString({
    required String value,
    int decimals = 18,
  }) {
    return EtherAmount(valueInWei: BigInt.parse(value), decimals: decimals);
  }

  @override
  int get hashCode => valueInWei.hashCode;

  BigInt get valueInWei => _valueInWei;

  @override
  bool operator ==(covariant EtherAmount other) {
    if (identical(this, other)) return true;

    return other.valueInWei == valueInWei;
  }

  String toEther({int fractionDigitAmount = 2}) {
    final double valueInEther = valueInWei / BigInt.from(pow(10, _decimals));
    return valueInEther.toStringAsFixed(fractionDigitAmount);
  }

  String toStorageString() => valueInWei.toString();

  @override
  String toString() => 'EtherAmount(wei: $valueInWei)';
}

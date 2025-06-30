class EtherAmount {
  final BigInt _valueInWei;

  EtherAmount({
    required BigInt valueInWei,
    int decimalPlaces = 2,
  }) : _valueInWei = valueInWei;

  factory EtherAmount.fromString(String value) {
    return EtherAmount(
      valueInWei: BigInt.parse(value),
      decimalPlaces: 2,
    );
  }

  @override
  int get hashCode => valueInWei.hashCode;

  BigInt get valueInWei => _valueInWei;

  @override
  bool operator ==(covariant EtherAmount other) {
    if (identical(this, other)) return true;

    return other.valueInWei == valueInWei;
  }

  String toReadableString([int decimalPlaces = 2]) {
    final double valueInEther = valueInWei / BigInt.from(1e18);
    return valueInEther.toStringAsFixed(decimalPlaces);
  }

  String toStorageString() => valueInWei.toString();

  @override
  String toString() => 'EtherAmount(wei: $valueInWei)';
}

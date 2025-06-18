class AccountBalance {
  final BigInt _valueInWei;
  final int _decimalPlaces;
  AccountBalance({
    required BigInt valueInWei,
    int decimalPlaces = 2,
  })  : _decimalPlaces = decimalPlaces,
        _valueInWei = valueInWei;

  factory AccountBalance.fromString(String value) {
    return AccountBalance(
      valueInWei: BigInt.parse(value),
      decimalPlaces: 2,
    );
  }

  @override
  int get hashCode => valueInWei.hashCode;

  BigInt get valueInWei => _valueInWei;
  int get decimalPlaces => _decimalPlaces;
  @override
  bool operator ==(covariant AccountBalance other) {
    if (identical(this, other)) return true;

    return other.valueInWei == valueInWei;
  }

  String toReadableString() {
    final double valueInEther = valueInWei / BigInt.from(1e18);
    return valueInEther.toStringAsFixed(_decimalPlaces);
  }

  String toStorageString() => valueInWei.toString();

  @override
  String toString() => 'AccountBalance(wei: $valueInWei)';
}

class AccountBalance {
  final BigInt _valueInWei;

  AccountBalance({
    required BigInt valueInWei,
    int decimalPlaces = 2,
  }) : _valueInWei = valueInWei;

  factory AccountBalance.fromString(String value) {
    return AccountBalance(
      valueInWei: BigInt.parse(value),
      decimalPlaces: 2,
    );
  }

  @override
  int get hashCode => valueInWei.hashCode;

  BigInt get valueInWei => _valueInWei;

  @override
  bool operator ==(covariant AccountBalance other) {
    if (identical(this, other)) return true;

    return other.valueInWei == valueInWei;
  }

  String toReadableString([int decimalPlaces = 2]) {
    final double valueInEther = valueInWei / BigInt.from(1e18);
    return valueInEther.toStringAsFixed(decimalPlaces);
  }

  String toStorageString() => valueInWei.toString();

  @override
  String toString() => 'AccountBalance(wei: $valueInWei)';
}

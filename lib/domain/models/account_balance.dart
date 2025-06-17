class AccountBalance {
  final BigInt valueInWei;

  AccountBalance(this.valueInWei) {
    if (valueInWei.isNegative) {
      throw ArgumentError('Account balance cannot be negative');
    }
  }

  factory AccountBalance.fromString(String value) {
    return AccountBalance(BigInt.parse(value));
  }

  String toStorageString() => valueInWei.toString();

  @override
  String toString() => 'AccountBalance(wei: $valueInWei)';

  @override
  bool operator ==(covariant AccountBalance other) {
    if (identical(this, other)) return true;

    return other.valueInWei == valueInWei;
  }

  @override
  int get hashCode => valueInWei.hashCode;
}

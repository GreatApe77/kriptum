// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Account {
  
  String address;
  String encryptedJsonWallet;
  Account({
    required this.address,
    required this.encryptedJsonWallet,
  });

  Account copyWith({
    String? address,
    String? encryptedJsonWallet,
  }) {
    return Account(
      address: address ?? this.address,
      encryptedJsonWallet: encryptedJsonWallet ?? this.encryptedJsonWallet,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'encryptedJsonWallet': encryptedJsonWallet,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      address: map['address'] as String,
      encryptedJsonWallet: map['encryptedJsonWallet'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Account(address: $address, encryptedJsonWallet: $encryptedJsonWallet)';

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.address == address &&
      other.encryptedJsonWallet == encryptedJsonWallet;
  }

  @override
  int get hashCode => address.hashCode ^ encryptedJsonWallet.hashCode;
}

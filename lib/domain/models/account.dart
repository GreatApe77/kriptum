// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Account {
  int accountIndex;
  String address;
  String encryptedJsonWallet;
  bool isImported;
  String? alias;
  Account({
    required this.accountIndex,
    required this.address,
    required this.encryptedJsonWallet,
    this.isImported = false,
    this.alias,
  });

  Account copyWith({
    int? accountIndex,
    String? address,
    String? encryptedJsonWallet,
    bool? isImported,
    String? alias,
  }) {
    return Account(
      accountIndex: accountIndex ?? this.accountIndex,
      address: address ?? this.address,
      encryptedJsonWallet: encryptedJsonWallet ?? this.encryptedJsonWallet,
      isImported: isImported ?? this.isImported,
      alias: alias ?? this.alias,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountIndex': accountIndex,
      'address': address,
      'encryptedJsonWallet': encryptedJsonWallet,
      'isImported': isImported,
      'alias': alias,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    bool isImported;
    if (map['isImported'] is num) {
      isImported = map['isImported'] == 0 ? false : true;
    }else{
      isImported = map['isImported'];
    }
    return Account(
      accountIndex: map['accountIndex'] as int,
      address: map['address'] as String,
      encryptedJsonWallet: map['encryptedJsonWallet'] as String,
      isImported: isImported,
      alias: map['alias'] != null ? map['alias'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Account(accountIndex: $accountIndex, address: $address, encryptedJsonWallet: $encryptedJsonWallet, isImported: $isImported, alias: $alias)';
  }

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;

    return other.accountIndex == accountIndex &&
        other.address == address &&
        other.encryptedJsonWallet == encryptedJsonWallet &&
        other.isImported == isImported &&
        other.alias == alias;
  }

  @override
  int get hashCode {
    return accountIndex.hashCode ^
        address.hashCode ^
        encryptedJsonWallet.hashCode ^
        isImported.hashCode ^
        alias.hashCode;
  }
}

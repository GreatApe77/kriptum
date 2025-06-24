// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Account {
  int? id;
  int accountIndex;
  String address;
  String encryptedJsonWallet;
  bool isImported;
  String? alias;
  Account({
    this.id,
    required this.accountIndex,
    required this.address,
    required this.encryptedJsonWallet,
    this.isImported = false,
    this.alias,
  });

  Account copyWith({
    int? id,
    int? accountIndex,
    String? address,
    String? encryptedJsonWallet,
    bool? isImported,
    String? alias,
  }) {
    return Account(
      id: id ?? this.id,
      accountIndex: accountIndex ?? this.accountIndex,
      address: address ?? this.address,
      encryptedJsonWallet: encryptedJsonWallet ?? this.encryptedJsonWallet,
      isImported: isImported ?? this.isImported,
      alias: alias ?? this.alias,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'accountIndex': accountIndex,
      'address': address,
      'encryptedJsonWallet': encryptedJsonWallet,
      'isImported': isImported,
      'alias': alias,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] != null ? map['id'] as int : null,
      accountIndex: map['accountIndex'] as int,
      address: map['address'] as String,
      encryptedJsonWallet: map['encryptedJsonWallet'] as String,
      isImported: map['isImported'] as bool,
      alias: map['alias'] != null ? map['alias'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Account(id: $id, accountIndex: $accountIndex, address: $address, encryptedJsonWallet: $encryptedJsonWallet, isImported: $isImported, alias: $alias)';
  }

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.accountIndex == accountIndex &&
      other.address == address &&
      other.encryptedJsonWallet == encryptedJsonWallet &&
      other.isImported == isImported &&
      other.alias == alias;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      accountIndex.hashCode ^
      address.hashCode ^
      encryptedJsonWallet.hashCode ^
      isImported.hashCode ^
      alias.hashCode;
  }
}

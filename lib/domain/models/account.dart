// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Account {
  
  String publicKey;
  String encryptedJsonWallet;
  Account({
    required this.publicKey,
    required this.encryptedJsonWallet,
  });

  Account copyWith({
    String? publicKey,
    String? encryptedJsonWallet,
  }) {
    return Account(
      publicKey: publicKey ?? this.publicKey,
      encryptedJsonWallet: encryptedJsonWallet ?? this.encryptedJsonWallet,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publicKey': publicKey,
      'encryptedJsonWallet': encryptedJsonWallet,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      publicKey: map['publicKey'] as String,
      encryptedJsonWallet: map['encryptedJsonWallet'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Account(publicKey: $publicKey, encryptedJsonWallet: $encryptedJsonWallet)';

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.publicKey == publicKey &&
      other.encryptedJsonWallet == encryptedJsonWallet;
  }

  @override
  int get hashCode => publicKey.hashCode ^ encryptedJsonWallet.hashCode;
}

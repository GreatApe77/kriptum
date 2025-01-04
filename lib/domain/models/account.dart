// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Account {
  String privateKey;
  String publicKey;
  Account({
    required this.privateKey,
    required this.publicKey,
  });

  Account copyWith({
    String? privateKey,
    String? publicKey,
  }) {
    return Account(
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'privateKey': privateKey,
      'publicKey': publicKey,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      privateKey: map['privateKey'] as String,
      publicKey: map['publicKey'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Account(privateKey: $privateKey, publicKey: $publicKey)';

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.privateKey == privateKey &&
      other.publicKey == publicKey;
  }

  @override
  int get hashCode => privateKey.hashCode ^ publicKey.hashCode;
}

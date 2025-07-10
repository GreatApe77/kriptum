// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Erc20Token {
  final int? id;
  final String address;
  final String? name;
  final String symbol;
  final int decimals;
  final int networkId;

  Erc20Token({
    this.id,
    required this.address,
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.networkId,
  });

  Erc20Token copyWith({
    int? id,
    String? address,
    String? name,
    String? symbol,
    int? decimals,
    int? networkId,
  }) {
    return Erc20Token(
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
      networkId: networkId ?? this.networkId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'networkId': networkId,
    };
  }

  factory Erc20Token.fromMap(Map<String, dynamic> map) {
    return Erc20Token(
      id: map['id'] != null ? map['id'] as int : null,
      address: map['address'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      symbol: map['symbol'] as String,
      decimals: map['decimals'] as int,
      networkId: map['networkId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Erc20Token.fromJson(String source) => Erc20Token.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Erc20Token(id: $id, address: $address, name: $name, symbol: $symbol, decimals: $decimals, networkId: $networkId)';
  }

  @override
  bool operator ==(covariant Erc20Token other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.address == address &&
      other.name == name &&
      other.symbol == symbol &&
      other.decimals == decimals &&
      other.networkId == networkId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      address.hashCode ^
      name.hashCode ^
      symbol.hashCode ^
      decimals.hashCode ^
      networkId.hashCode;
  }
}

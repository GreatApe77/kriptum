// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Network {
  int? id;
  String rpcUrl;
  String name;
  String? blockExplorerName;
  String? blockExplorerUrl;
  String ticker;
  int currencyDecimals;
  Network({
    this.id,
    required this.rpcUrl,
    required this.name,
    this.blockExplorerName,
    this.blockExplorerUrl,
    required this.ticker,
    required this.currencyDecimals,
  });

  Network copyWith({
    int? id,
    String? rpcUrl,
    String? name,
    String? blockExplorerName,
    String? blockExplorerUrl,
    String? ticker,
    int? currencyDecimals,
  }) {
    return Network(
      id: id ?? this.id,
      rpcUrl: rpcUrl ?? this.rpcUrl,
      name: name ?? this.name,
      blockExplorerName: blockExplorerName ?? this.blockExplorerName,
      blockExplorerUrl: blockExplorerUrl ?? this.blockExplorerUrl,
      ticker: ticker ?? this.ticker,
      currencyDecimals: currencyDecimals ?? this.currencyDecimals,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rpcUrl': rpcUrl,
      'name': name,
      'blockExplorerName': blockExplorerName,
      'blockExplorerUrl': blockExplorerUrl,
      'ticker': ticker,
      'currencyDecimals': currencyDecimals,
    };
  }

  factory Network.fromMap(Map<String, dynamic> map) {
    return Network(
      id: map['id'] != null ? map['id'] as int : null,
      rpcUrl: map['rpcUrl'] as String,
      name: map['name'] as String,
      blockExplorerName: map['blockExplorerName'] != null
          ? map['blockExplorerName'] as String
          : null,
      blockExplorerUrl: map['blockExplorerUrl'] != null
          ? map['blockExplorerUrl'] as String
          : null,
      ticker: map['ticker'] as String,
      currencyDecimals: map['currencyDecimals'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Network.fromJson(String source) =>
      Network.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Network(id: $id, rpcUrl: $rpcUrl, name: $name, blockExplorerName: $blockExplorerName, blockExplorerUrl: $blockExplorerUrl, ticker: $ticker, currencyDecimals: $currencyDecimals)';
  }

  @override
  bool operator ==(covariant Network other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rpcUrl == rpcUrl &&
        other.name == name &&
        other.blockExplorerName == blockExplorerName &&
        other.blockExplorerUrl == blockExplorerUrl &&
        other.ticker == ticker &&
        other.currencyDecimals == currencyDecimals;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rpcUrl.hashCode ^
        name.hashCode ^
        blockExplorerName.hashCode ^
        blockExplorerUrl.hashCode ^
        ticker.hashCode ^
        currencyDecimals.hashCode;
  }
}

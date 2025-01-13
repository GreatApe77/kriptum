// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Settings {
  int lastConnectedIndex;
  bool isDarkTheme;
  bool containsWallet;
  int lastConnectedChainId;
  Settings({
    required this.lastConnectedIndex,
    required this.isDarkTheme,
    required this.containsWallet,
    required this.lastConnectedChainId,
  });
  

  Settings copyWith({
    int? lastConnectedIndex,
    bool? isDarkTheme,
    bool? containsWallet,
    int? lastConnectedChainId,
  }) {
    return Settings(
      lastConnectedIndex: lastConnectedIndex ?? this.lastConnectedIndex,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      containsWallet: containsWallet ?? this.containsWallet,
      lastConnectedChainId: lastConnectedChainId ?? this.lastConnectedChainId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastConnectedIndex': lastConnectedIndex,
      'isDarkTheme': isDarkTheme,
      'containsWallet': containsWallet,
      'lastConnectedChainId': lastConnectedChainId,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      lastConnectedIndex: map['lastConnectedIndex'] as int,
      isDarkTheme: map['isDarkTheme'] as bool,
      containsWallet: map['containsWallet'] as bool,
      lastConnectedChainId: map['lastConnectedChainId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) => Settings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Settings(lastConnectedIndex: $lastConnectedIndex, isDarkTheme: $isDarkTheme, containsWallet: $containsWallet, lastConnectedChainId: $lastConnectedChainId)';
  }

  @override
  bool operator ==(covariant Settings other) {
    if (identical(this, other)) return true;
  
    return 
      other.lastConnectedIndex == lastConnectedIndex &&
      other.isDarkTheme == isDarkTheme &&
      other.containsWallet == containsWallet &&
      other.lastConnectedChainId == lastConnectedChainId;
  }

  @override
  int get hashCode {
    return lastConnectedIndex.hashCode ^
      isDarkTheme.hashCode ^
      containsWallet.hashCode ^
      lastConnectedChainId.hashCode;
  }
}

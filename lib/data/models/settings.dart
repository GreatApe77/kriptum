// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Settings {
  int lastConnectedIndex;
  bool isDarkTheme;
  bool containsWallet;
  bool isLockedWallet;
  bool hideBalance;
  int lastConnectedChainId;
  int nextHdAccountIndex;
  Settings({
    required this.lastConnectedIndex,
    required this.isDarkTheme,
    required this.containsWallet,
    required this.isLockedWallet,
    required this.hideBalance,
    required this.lastConnectedChainId,
    required this.nextHdAccountIndex,
  });
  

  Settings copyWith({
    int? lastConnectedIndex,
    bool? isDarkTheme,
    bool? containsWallet,
    bool? isLockedWallet,
    bool? hideBalance,
    int? lastConnectedChainId,
    int? nextHdAccountIndex,
  }) {
    return Settings(
      lastConnectedIndex: lastConnectedIndex ?? this.lastConnectedIndex,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      containsWallet: containsWallet ?? this.containsWallet,
      isLockedWallet: isLockedWallet ?? this.isLockedWallet,
      hideBalance: hideBalance ?? this.hideBalance,
      lastConnectedChainId: lastConnectedChainId ?? this.lastConnectedChainId,
      nextHdAccountIndex: nextHdAccountIndex ?? this.nextHdAccountIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastConnectedIndex': lastConnectedIndex,
      'isDarkTheme': isDarkTheme,
      'containsWallet': containsWallet,
      'isLockedWallet': isLockedWallet,
      'hideBalance': hideBalance,
      'lastConnectedChainId': lastConnectedChainId,
      'nextHdAccountIndex': nextHdAccountIndex,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      lastConnectedIndex: map['lastConnectedIndex'] as int,
      isDarkTheme: map['isDarkTheme'] as bool,
      containsWallet: map['containsWallet'] as bool,
      isLockedWallet: map['isLockedWallet'] as bool,
      hideBalance: map['hideBalance'] as bool,
      lastConnectedChainId: map['lastConnectedChainId'] as int,
      nextHdAccountIndex: map['nextHdAccountIndex'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) => Settings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Settings(lastConnectedIndex: $lastConnectedIndex, isDarkTheme: $isDarkTheme, containsWallet: $containsWallet, isLockedWallet: $isLockedWallet, hideBalance: $hideBalance, lastConnectedChainId: $lastConnectedChainId, nextHdAccountIndex: $nextHdAccountIndex)';
  }

  @override
  bool operator ==(covariant Settings other) {
    if (identical(this, other)) return true;
  
    return 
      other.lastConnectedIndex == lastConnectedIndex &&
      other.isDarkTheme == isDarkTheme &&
      other.containsWallet == containsWallet &&
      other.isLockedWallet == isLockedWallet &&
      other.hideBalance == hideBalance &&
      other.lastConnectedChainId == lastConnectedChainId &&
      other.nextHdAccountIndex == nextHdAccountIndex;
  }

  @override
  int get hashCode {
    return lastConnectedIndex.hashCode ^
      isDarkTheme.hashCode ^
      containsWallet.hashCode ^
      isLockedWallet.hashCode ^
      hideBalance.hashCode ^
      lastConnectedChainId.hashCode ^
      nextHdAccountIndex.hashCode;
  }
}

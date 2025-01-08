// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Settings {
  int lastConnectedIndex;
  bool isDarkTheme;
  Settings({
    required this.lastConnectedIndex,
    required this.isDarkTheme,
  });
  

  Settings copyWith({
    int? lastConnectedIndex,
    bool? isDarkTheme,
  }) {
    return Settings(
      lastConnectedIndex: lastConnectedIndex ?? this.lastConnectedIndex,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastConnectedIndex': lastConnectedIndex,
      'isDarkTheme': isDarkTheme,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      lastConnectedIndex: map['lastConnectedIndex'] as int,
      isDarkTheme: map['isDarkTheme'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) => Settings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Settings(lastConnectedIndex: $lastConnectedIndex, isDarkTheme: $isDarkTheme)';

  @override
  bool operator ==(covariant Settings other) {
    if (identical(this, other)) return true;
  
    return 
      other.lastConnectedIndex == lastConnectedIndex &&
      other.isDarkTheme == isDarkTheme;
  }

  @override
  int get hashCode => lastConnectedIndex.hashCode ^ isDarkTheme.hashCode;
}

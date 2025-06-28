import 'package:kriptum/infra/persistence/database/sqflite/tables/accounts_table.dart';

Map<String, dynamic> mapIntToBoolean(Map<String, dynamic> entry) {
  final updatedMap = Map<String, dynamic>.from(entry);

  final intValue = entry[AccountsTable.isImportedColumn];
  updatedMap[AccountsTable.isImportedColumn] = intValue != null && intValue == 1;

  return updatedMap;
}

Map<String, dynamic> mapBooleanToInt(Map<String, dynamic> entry) {
  final updatedMap = Map<String, dynamic>.from(entry);

  final boolValue = entry[AccountsTable.isImportedColumn];
  updatedMap[AccountsTable.isImportedColumn] = (boolValue == true) ? 1 : 0;

  return updatedMap;
}

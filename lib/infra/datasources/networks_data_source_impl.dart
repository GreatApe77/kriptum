import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/infra/datasources/networks_data_source.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/networks_table.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';

class NetworksDataSourceImpl implements NetworksDataSource {
  final SqlDatabase _sqlDatabase;
  NetworksDataSourceImpl(this._sqlDatabase);
  @override
  Future<List<Network>> getAllNetworks() async {
    final rawData = await _sqlDatabase.query(
      NetworksTable.table,
    );
    return rawData
        .map(
          (row) => Network.fromMap(row),
        )
        .toList();
  }

  @override
  Future<Network?> getNetworkById(int networkId) async {
    final rawData = await _sqlDatabase.query(
      NetworksTable.table,
      where: '${NetworksTable.idColumn} = ?',
      whereArgs: [networkId],
    );
    if (rawData.isEmpty) {
      return null;
    }
    return Network.fromMap(rawData.first);
  }
}

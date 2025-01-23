import 'package:kriptum/data/database/networks_table.dart';
import 'package:kriptum/data/database/sqlite_database.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/domain/exceptions/duplicated_network_exception.dart';
import 'package:kriptum/domain/exceptions/network_not_found_exception.dart';
import 'package:kriptum/domain/models/network.dart';

class NetworkRepositoryDbImplementation implements NetworkRepository {
  @override
  Future<Network> getNetworkById(int id) async {
    final database = await SqliteDatabase().db;
    final result = await database.query(NetworksTable.table,
        where: '${NetworksTable.idColumn} = ?', whereArgs: [id]);
    if (result.isEmpty) throw NetworkNotFoundException();
    return Network.fromMap(result.first);
  }

  @override
  Future<List<Network>> loadNetworks() async {
    final database = await SqliteDatabase().db;
    final result = await database.query(NetworksTable.table);
    return result
        .map(
          (networkMap) => Network.fromMap(networkMap),
        )
        .toList();
  }

  @override
  Future<void> saveNetwork(Network network) async {
    try {
      final database = await SqliteDatabase().db;
      await database.insert(NetworksTable.table, network.toMap());
    } catch (e) {
      throw DuplicatedNetworkException();
    }
  }
}

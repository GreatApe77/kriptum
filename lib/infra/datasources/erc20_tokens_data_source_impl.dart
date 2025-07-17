import 'package:kriptum/domain/models/erc20_token.dart';
import 'package:kriptum/infra/datasources/data_sources.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/erc20_tokens_table.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';

class Erc20TokensDataSourceImpl implements Erc20TokensDataSource {
  final SqlDatabase _database;

  Erc20TokensDataSourceImpl(this._database);

  @override
  Future<void> delete(int tokenId) async {
    await _database.delete(Erc20TokensTable.table, '${Erc20TokensTable.columnId} = ?', [tokenId]);
  }

  @override
  Future<void> deleteAll() async {
    await _database.deleteAll(Erc20TokensTable.table);
  }

  @override
  Future<Erc20Token?> findByAddress(String contractAddress) async {
    final result = await _database.query(
      Erc20TokensTable.table,
      where: '${Erc20TokensTable.columnAddress} = ?',
      whereArgs: [contractAddress],
    );
    if (result.isEmpty) return null;
    return Erc20Token.fromMap(result.first);
  }

  @override
  Future<Erc20Token?> findById(int tokenId) async {
    final result = await _database.query(
      Erc20TokensTable.table,
      where: '${Erc20TokensTable.columnId} = ?',
      whereArgs: [tokenId],
    );
    if (result.isEmpty) return null;
    return Erc20Token.fromMap(result.first);
  }

  @override
  Future<List<Erc20Token>> getAllImportedTokensOfNetwork(int networkId) async {
    final result = await _database.query(
      Erc20TokensTable.table,
      where: '${Erc20TokensTable.columnNetworkId} = ?',
      whereArgs: [networkId],
    );
    return result.map((e) => Erc20Token.fromMap(e)).toList();
  }

  @override
  Future<List<Erc20Token>> getAllTokens() async {
    final result = await _database.query(Erc20TokensTable.table);
    return result.map((e) => Erc20Token.fromMap(e)).toList();
  }

  @override
  Future<void> save(Erc20Token token) async {
    await _database.insert(Erc20TokensTable.table, token.toMap());
  }
}

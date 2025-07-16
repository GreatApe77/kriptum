import 'package:kriptum/domain/models/erc20_token.dart';
import 'package:kriptum/domain/repositories/erc20_token_repository.dart';
import 'package:kriptum/infra/datasources/erc20_tokens_data_source.dart';

class Erc20TokenRepositoryImpl implements Erc20TokenRepository {
  final Erc20TokensDataSource _dataSource;

  Erc20TokenRepositoryImpl(this._dataSource);
  @override
  Future<void> delete(int tokenId) async {
    await _dataSource.delete(tokenId);
  }

  @override
  Future<Erc20Token?> findByAddress(String contractAddress) async {
    return await _dataSource.findByAddress(contractAddress);
  }

  @override
  Future<List<Erc20Token>> getAllImportedTokensOfNetwork(int networkId) async {
    return await _dataSource.getAllImportedTokensOfNetwork(networkId);
  }

  @override
  Future<List<Erc20Token>> getAllTokens() async {
    return await _dataSource.getAllTokens();
  }

  @override
  Future<void> save(Erc20Token token) async {
    await _dataSource.save(token);
  }

  @override
  Stream<List<Erc20Token>> watchTokensOfCurrentNetwork() {
    // TODO: implement watchTokensOfCurrentNetwork
    throw UnimplementedError();
  }
}

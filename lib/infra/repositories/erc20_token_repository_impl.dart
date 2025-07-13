import 'package:kriptum/domain/models/erc20_token.dart';
import 'package:kriptum/domain/repositories/erc20_token_repository.dart';

class Erc20TokenRepositoryImpl implements Erc20TokenRepository {
  @override
  Future<void> delete(int tokenId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Erc20Token?> findByAddress(String contractAddress) {
    // TODO: implement findByAddress
    throw UnimplementedError();
  }

  @override
  Future<List<Erc20Token>> getAllImportedTokensOfNetwork(int networkId) {
    // TODO: implement getAllImportedTokensOfNetwork
    throw UnimplementedError();
  }

  @override
  Future<List<Erc20Token>> getAllTokens() {
    // TODO: implement getAllTokens
    throw UnimplementedError();
  }

  @override
  Future<void> save(Erc20Token token) {
    // TODO: implement save
    throw UnimplementedError();
  }
  
}
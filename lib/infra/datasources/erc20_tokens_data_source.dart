import 'package:kriptum/domain/models/erc20_token.dart';

abstract interface class Erc20TokensDataSource {
  Future<void> save(Erc20Token token);
  Future<void> delete(int tokenId);
  Future<Erc20Token?> findByAddress(String contractAddress);
  Future<List<Erc20Token>> getAllTokens();
  Future<List<Erc20Token>> getAllImportedTokensOfNetwork(int networkId);
  Future<Erc20Token?> findById(int tokenId);
  Future<void> deleteAll();
}

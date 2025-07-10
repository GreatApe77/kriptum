import 'package:kriptum/domain/models/erc20_token.dart';

abstract interface class Erc20TokenRepository {
  Future<void> save(Erc20Token token);
  Future<List<Erc20Token>> getAllTokens();
  Future<void> delete(int tokenId);
  Future<Erc20Token?> findByAddress(String contractAddress);
  Future<List<Erc20Token>> getAllImportedTokensOfNetwork(int networkId);
}
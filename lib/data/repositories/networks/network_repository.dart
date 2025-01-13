import 'package:kriptum/domain/models/network.dart';

abstract class NetworkRepository {
  Future<void> saveNetwork(Network network);
  Future<List<Network>> loadNetworks();
  Future<Network> getNetworkById(int id);
}
import 'package:kriptum/domain/models/network.dart';

abstract interface class NetworksRepository {
  Future<Network> getCurrentNetwork();
  Future<List<Network>> getAllNetworks();
  Future<void> changeCurrentNetwork(Network network);
  Stream<Network> watchCurrentNetwork();
}
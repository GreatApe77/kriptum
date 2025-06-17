import 'package:kriptum/domain/models/network.dart';

abstract interface class NetworksDataSource {
    Future<Network?> getNetworkById(int networkId);
    Future<List<Network>> getAllNetworks();
}
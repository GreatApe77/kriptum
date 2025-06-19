import 'dart:async';

import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/infra/datasources/networks_data_source.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';

class NetworksRepositoryImpl implements NetworksRepository {
  final UserPreferences _userPreferences;
  final NetworksDataSource _networksDataSource;
  final StreamController<Network> _currentNetworkController =
      StreamController<Network>.broadcast();
  Network? _currentNetwork;
  NetworksRepositoryImpl(
    this._userPreferences,
    this._networksDataSource,
  );
  @override
  Future<Network> getCurrentNetwork() async {
    if (_currentNetwork != null) {
      return _currentNetwork!;
    }
    final networkId = await _userPreferences.getSelectedNetworkId();
    final retrievedNetwork =
        await _networksDataSource.getNetworkById(networkId);
    if (retrievedNetwork == null) {
      throw Exception('Network with id $networkId not found');
    }
    _currentNetwork = retrievedNetwork;
    return _currentNetwork!;
  }

  @override
  Future<void> changeCurrentNetwork(Network network) async {
    _currentNetwork = network;
    _currentNetworkController.add(_currentNetwork!);
    await _userPreferences.setSelectedNetworkId(network.id!);
  }

  @override
  Stream<Network> watchCurrentNetwork() => _currentNetworkController.stream;

  @override
  Future<List<Network>> getAllNetworks() async {
    return await _networksDataSource.getAllNetworks();
  }
}

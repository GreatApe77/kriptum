import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/domain/models/network.dart';

class CurrentNetworkController extends ChangeNotifier {
  Network? _currentConnectedNetwork;
  final NetworkRepository _networkRepository;
  CurrentNetworkController({required NetworkRepository networkRepository})
      : _networkRepository = networkRepository;
  Network? get currentConnectedNetwork => _currentConnectedNetwork;

  void loadCurrentConnectedNetwork(int networkId) async {
    _currentConnectedNetwork =
        await _networkRepository.getNetworkById(networkId);
    notifyListeners();
  }
  void switchNetwork(Network network){
    _currentConnectedNetwork = network;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/domain/exceptions/duplicated_network_exception.dart';
import 'package:kriptum/domain/models/network.dart';

class NetworksController extends ChangeNotifier {
  List<Network> _filteredList = [];
  List<Network> _networks = [];
  Network? _currentConnectedNetwork;
  final NetworkRepository _networkRepository;
  NetworksController({required NetworkRepository networkRepository})
      : _networkRepository = networkRepository;
  Network? get currentConnectedNetwork => _currentConnectedNetwork;
  List<Network> get networks => _networks;
  List<Network> get filteredList => _filteredList;
  void filterNetworks(String nameFilter) {
    _filteredList = _networks
        .where(
          (network) =>  network.name.toLowerCase().startsWith(nameFilter.toLowerCase()),
        )
        .toList();

    notifyListeners();
    
  }

  addNetwork({
    required int id,
    required String name,
    required String rpcUrl,
    String? blockExplorerName,
    String? blockExplorerUrl,
    required String ticker,
    int? currencyDecimals,
    required Function() onSuccess,
    required Function() onFail,
  }) async {
    try {
      final Network network = Network(
          rpcUrl: rpcUrl,
          name: name,
          ticker: ticker,
          currencyDecimals: currencyDecimals ?? 18,
          blockExplorerName: blockExplorerName,
          blockExplorerUrl: blockExplorerUrl,
          id: id);

      //_networks.add(network);
      await _networkRepository.saveNetwork(network);
      notifyListeners();
      onSuccess();
    } on DuplicatedNetworkException {
      onFail();
    }
  }

  loadCurrentConnectedNetwork(int networkId) async {
    _currentConnectedNetwork =
        await _networkRepository.getNetworkById(networkId);
    notifyListeners();
  }

  loadNetworks() async {
    _networks = await _networkRepository.loadNetworks();
    notifyListeners();
  }
  switchNetwork(int index,{required Function() onSuccess}){
    _currentConnectedNetwork = networks[index];
    onSuccess();
    notifyListeners();
  }
  
}

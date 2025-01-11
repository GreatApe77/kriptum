import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/domain/models/network.dart';

class NetworksController extends ChangeNotifier {
  List<Network> _networks = [];
  final NetworkRepository _networkRepository;
  List<Network> get networks =>_networks;
  NetworksController({required NetworkRepository networkRepository})
      : _networkRepository = networkRepository;

  loadNetworks()async{
    _networks = await _networkRepository.loadNetworks();
    notifyListeners();
  }

  
  

}


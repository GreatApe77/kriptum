import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/domain/models/network.dart';

class NetworkRepositoryMemoryImpl implements NetworkRepository {
  final _repo = [
    Network(rpcUrl: 'https://rpc.sepolia.org', name: 'Sepolia', ticker: 'ETH', currencyDecimals: 18),
    //Network(rpcUrl: '', name: 'Ethereum Mainnet', ticker: 'ETH', currencyDecimals: 18),
   // Network(rpcUrl: '', name: 'Sepolia', ticker: 'ETH', currencyDecimals: 18),
   // Network(rpcUrl: '', name: 'Sepolia', ticker: 'ETH', currencyDecimals: 18),
   // Network(rpcUrl: '', name: 'Sepolia', ticker: 'ETH', currencyDecimals: 18),
  ];

  @override
  Future<List<Network>> loadNetworks() {
    return Future.value(_repo);
  }

  @override
  Future<void> saveNetwork(Network network) {
    _repo.add(network);
    return Future.value();
  }
}

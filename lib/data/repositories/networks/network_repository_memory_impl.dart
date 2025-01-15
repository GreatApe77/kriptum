import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/domain/exceptions/network_not_found_exception.dart';
import 'package:kriptum/domain/models/network.dart';

class NetworkRepositoryMemoryImpl implements NetworkRepository {
  final _repo = [
    Network(
        id: 11155111,
        rpcUrl: 'https://endpoints.omniatech.io/v1/eth/sepolia/public',
        name: 'Sepolia',
        ticker: 'ETH',
        currencyDecimals: 18),
    Network(
        id: 1,
        rpcUrl: 'https://cloudflare-eth.com',
        name: 'Ethereum Mainnet',
        ticker: 'ETH',
        currencyDecimals: 18),
    Network(
        id: 97,
        rpcUrl: 'https://rpc.testnet.fantom.network',
        name: 'Fantom Testnet',
        ticker: 'FTM',
        currencyDecimals: 18),
    Network(
        id: 1337,
        rpcUrl: 'http://10.0.2.2:8545',
        name: 'Localhost',
        ticker: 'ETH',
        currencyDecimals: 18),
    
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

  @override
  Future<Network> getNetworkById(int id) {
    Network network = _repo.firstWhere(
      (network) => network.id == id,
      orElse: () {
        throw NetworkNotFoundException();
      },
    );
    return Future.value(network);
  }
}

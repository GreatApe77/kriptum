import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/domain/exceptions/network_not_found_exception.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/ui/shared/constants/standard_networks.dart';

class NetworkRepositoryMemoryImpl implements NetworkRepository {
  final _repo = standardNetworks;

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

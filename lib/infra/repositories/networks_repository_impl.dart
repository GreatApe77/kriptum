import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/infra/datasources/networks_data_source.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';

class NetworksRepositoryImpl implements NetworksRepository {
  final UserPreferences _userPreferences;
  final NetworksDataSource _networksDataSource;
  NetworksRepositoryImpl(
    this._userPreferences,
    this._networksDataSource,
  );
  @override
  Future<Network> getCurrentNetwork() async {
    final networkId = await _userPreferences.getSelectedNetworkId();
    final network = await _networksDataSource.getNetworkById(networkId);
    if (network == null) {
      throw Exception('Network with id $networkId not found');
    }
    return network;
  }
}

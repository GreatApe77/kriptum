import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
part 'current_network_state.dart';

class CurrentNetworkCubit extends Cubit<CurrentNetworkState> {
  final NetworksRepository _networksRepository;
  CurrentNetworkCubit(
    this._networksRepository,
  ) : super(
          CurrentNetworkLoaded(
            network: Network(
              id: 1,
              name: 'Ethereum',
              currencyDecimals: 18,
              rpcUrl: '',
              ticker: 'ETH',
              blockExplorerName: 'a',
              blockExplorerUrl: '',
            ),
          ),
        );
}

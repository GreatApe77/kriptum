import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';

part 'networks_list_event.dart';
part 'networks_list_state.dart';

class NetworksListBloc extends Bloc<NetworksListEvent, NetworksListState> {
  final NetworksRepository _networksRepository;
  NetworksListBloc(
    this._networksRepository,
  ) : super(NetworksListState.initial()) {
    on<NetworksListFiltered>((event, emit) {
      final filter = event.filter.toLowerCase();
      final filteredNetworks = state.networks.where((network) => network.name.toLowerCase().contains(filter)).toList();

      emit(
        state.copyWith(
          filteredNetworks: filteredNetworks,
          filter: event.filter,
        ),
      );
    });
    on<NetworksListRequested>((event, emit) async {
      print('Ta caindo aqui');
      try {
        emit(state.copyWith(status: NetworksListStatus.loading));
        final networks = await _networksRepository.getAllNetworks();
        /*        final mockNetworks = [
          Network(
            id: 1,
            name: 'Ethereum',
            currencyDecimals: 18,
            rpcUrl: '',
            ticker: 'ETH',
            blockExplorerName: 'a',
            blockExplorerUrl: '',
          ),
          Network(
            id: 2,
            name: 'Anything else',
            currencyDecimals: 18,
            rpcUrl: '',
            ticker: 'ETH',
            blockExplorerName: 'a',
            blockExplorerUrl: '',
          ),
        ]; */

        emit(
          state.copyWith(
            status: NetworksListStatus.loaded,
            networks: networks,
            filteredNetworks: networks,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: NetworksListStatus.error,
            errorMessage: 'Failed to load networks',
          ),
        );
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/network.dart';

part 'networks_list_event.dart';
part 'networks_list_state.dart';

class NetworksListBloc extends Bloc<NetworksListEvent, NetworksListState> {
  NetworksListBloc() : super(NetworksListState.initial()) {
    on<NetworksListFiltered>((event, emit) {
      final filter = event.filter.toLowerCase();
      final filteredNetworks = state.networks
          .where((network) => network.name.toLowerCase().contains(filter))
          .toList();

      emit(
        state.copyWith(
          filteredNetworks: filteredNetworks,
          filter: event.filter,
        ),
      );
    });
    on<NetworksListRequested>((event, emit) {
      try {
        emit(state.copyWith(status: NetworksListStatus.loading));

        final mockNetworks = [
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
        ];

        emit(
          state.copyWith(
            status: NetworksListStatus.loaded,
            networks: mockNetworks,
            filteredNetworks: mockNetworks,
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

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
part 'current_network_state.dart';

class CurrentNetworkCubit extends Cubit<CurrentNetworkState> {
  final NetworksRepository _networksRepository;
  late final StreamSubscription<Network> _currentNetworkSubscription;
  CurrentNetworkCubit(
    this._networksRepository,
  ) : super(CurrentNetworkInitial()) {
    _currentNetworkSubscription = _networksRepository.watchCurrentNetwork().listen(
          (event) => _handleNetworkChange(event),
        );
  }
  Future<void> changeCurrentNetwork(Network network) async {
    try {
      await _networksRepository.changeCurrentNetwork(network);
    } on Exception catch (e) {
      emit(
        CurrentNetworkError(error: e),
      );
    } catch (e) {
      emit(
        CurrentNetworkError(error: Exception('')),
      );
    }
  }

  Future<void> requestCurrentNetwork() async {
    emit(CurrentNetworkLoading());
    try {
      final network = await _networksRepository.getCurrentNetwork();
      emit(
        CurrentNetworkLoaded(network: network, isChangingNetwork: false),
      );
    } on Exception catch (e) {
      emit(CurrentNetworkError(error: e));
    } catch (e) {
      emit(CurrentNetworkError(error: Exception('')));
    }
  }

  void _handleNetworkChange(Network network) {
    emit(
      CurrentNetworkLoaded(
        network: network,
        isChangingNetwork: true,
      ),
    );
  }

  @override
  Future<void> close() {
    _currentNetworkSubscription.cancel();
    return super.close();
  }
}

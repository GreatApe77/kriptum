// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'networks_list_bloc.dart';

enum NetworksListStatus {
  initial,
  loading,
  loaded,
  error,
}

class NetworksListState {
  final NetworksListStatus status;
  final List<Network> networks;
  final List<Network> filteredNetworks;
  final Exception error;
  final String filter;

  NetworksListState({
    required this.status,
    required this.networks,
    required this.filteredNetworks,
    required this.error,
    required this.filter,
  });
  factory NetworksListState.initial() {
    return NetworksListState(
      status: NetworksListStatus.initial,
      networks: [],
      filteredNetworks: [],
      error: Exception(''),
      filter: '',
    );
  }

  NetworksListState copyWith({
    NetworksListStatus? status,
    List<Network>? networks,
    List<Network>? filteredNetworks,
    Exception? error,
    String? filter,
  }) {
    return NetworksListState(
      status: status ?? this.status,
      networks: networks ?? this.networks,
      filteredNetworks: filteredNetworks ?? this.filteredNetworks,
      error: error ?? this.error,
      filter: filter ?? this.filter,
    );
  }
}

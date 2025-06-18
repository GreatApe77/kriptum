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
  final String? errorMessage;
  final String filter;

  NetworksListState({
    required this.status,
    required this.networks,
    required this.filteredNetworks,
    required this.errorMessage,
    required this.filter,
  });
   factory NetworksListState.initial() {
    return NetworksListState(
      status: NetworksListStatus.initial,
      networks: [],
      filteredNetworks: [],
      errorMessage: null,
      filter: '',
    );
  } 

  NetworksListState copyWith({
    NetworksListStatus? status,
    List<Network>? networks,
    List<Network>? filteredNetworks,
    String? errorMessage,
    String? filter,
  }) {
    return NetworksListState(
      status: status ?? this.status,
      networks: networks ?? this.networks,
      filteredNetworks: filteredNetworks ?? this.filteredNetworks,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }

}

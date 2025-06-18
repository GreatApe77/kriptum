part of 'networks_list_bloc.dart';

sealed class NetworksListEvent {}

class NetworksListRequested extends NetworksListEvent {}

class NetworksListFiltered extends NetworksListEvent {
  final String filter;

  NetworksListFiltered({required this.filter});
}

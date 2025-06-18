part of 'current_network_cubit.dart';

sealed class CurrentNetworkState {}

final class CurrentNetworkInitial extends CurrentNetworkState {}

final class CurrentNetworkLoaded extends CurrentNetworkState {
  final Network network;

  CurrentNetworkLoaded({required this.network});
}

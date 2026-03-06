part of 'current_network_cubit.dart';

sealed class CurrentNetworkState {}

final class CurrentNetworkInitial extends CurrentNetworkState {}

final class CurrentNetworkLoading extends CurrentNetworkState {}

final class CurrentNetworkError extends CurrentNetworkState {
  final Exception error;

  CurrentNetworkError({required this.error});
}

final class CurrentNetworkLoaded extends CurrentNetworkState {
  final Network network;
  final bool isChangingNetwork;

  CurrentNetworkLoaded({required this.network, required this.isChangingNetwork});
}

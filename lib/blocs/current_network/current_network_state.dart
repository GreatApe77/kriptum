part of 'current_network_cubit.dart';

sealed class CurrentNetworkState {}

final class CurrentNetworkInitial extends CurrentNetworkState {}

final class CurrentNetworkLoading extends CurrentNetworkState {}

final class CurrentNetworkError extends CurrentNetworkState {
  final String message;

  CurrentNetworkError({required this.message});
}

final class CurrentNetworkLoaded extends CurrentNetworkState {
  final Network network;
  final bool isChangingNetwork;

  CurrentNetworkLoaded({required this.network, required this.isChangingNetwork});
}

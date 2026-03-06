part of 'balances_bloc.dart';

sealed class BalancesState {}

final class BalancesInitial extends BalancesState {}

final class BalancesLoading extends BalancesState {}

final class BalancesError extends BalancesState {
  final Exception error;

  BalancesError({required this.error});
}

final class BalancesLoaded extends BalancesState {
  final Map<String, EthereumAmount> balanceOf;

  BalancesLoaded({required this.balanceOf});
}

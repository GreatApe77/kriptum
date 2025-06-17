part of 'native_balance_bloc.dart';

sealed class NativeBalanceState {}

final class NativeBalanceInitial extends NativeBalanceState {}

final class NativeBalanceLoading extends NativeBalanceState {}

final class NativeBalanceLoaded extends NativeBalanceState {
  final AccountBalance accountBalance;

  NativeBalanceLoaded({
    required this.accountBalance,
  });
}

final class NativeBalanceError extends NativeBalanceState {
  final String errorMessage;

  NativeBalanceError({
    required this.errorMessage,
  });
}

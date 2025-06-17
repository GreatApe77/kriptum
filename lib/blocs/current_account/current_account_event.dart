part of 'current_account_bloc.dart';

sealed class CurrentAccountEvent {}

final class CurrentAccountRequested extends CurrentAccountEvent {}

final class CurrentAccountChanged extends CurrentAccountEvent {
  final Account account;

  CurrentAccountChanged({
    required this.account,
  });
}


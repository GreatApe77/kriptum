part of 'current_native_balance_bloc.dart';

sealed class CurrentNativeBalanceEvent {}

final class CurrentNativeBalanceRequested extends CurrentNativeBalanceEvent {}

final class CurrentNativeBalanceVisibilityRequested extends CurrentNativeBalanceEvent {}

final class ToggleCurrentNativeBalanceVisibility extends CurrentNativeBalanceEvent {
  final bool isVisible;

  ToggleCurrentNativeBalanceVisibility({
    required this.isVisible,
  });
}

part of 'native_balance_bloc.dart';

sealed class NativeBalanceEvent {}

final class NativeBalanceRequested extends NativeBalanceEvent {}
final class NativeBalanceVisibilityRequested extends NativeBalanceEvent {}
final class ToggleNativeBalanceVisibility extends NativeBalanceEvent {
  final bool isVisible;

  ToggleNativeBalanceVisibility({
    required this.isVisible,
  });
}
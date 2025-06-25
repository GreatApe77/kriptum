part of 'lock_wallet_bloc.dart';


sealed class LockWalletEvent {}

final class LockWalletRequested extends LockWalletEvent{}
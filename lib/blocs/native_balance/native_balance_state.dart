// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'native_balance_bloc.dart';

enum NativeBalanceStatus {
  initial,
  loading,
  loaded,
  error,
}

class NativeBalanceState {
  final bool isVisible;
  final EtherAmount? accountBalance;
  final String? errorMessage;
  final NativeBalanceStatus status;
  final String ticker;

  NativeBalanceState(
      {required this.isVisible,
      required this.accountBalance,
      required this.errorMessage,
      required this.status,
      required this.ticker});
  factory NativeBalanceState.initial() {
    return NativeBalanceState(
        isVisible: false, accountBalance: null, errorMessage: null, status: NativeBalanceStatus.initial, ticker: '');
  }

  NativeBalanceState copyWith({
    bool? isVisible,
    EtherAmount? accountBalance,
    String? errorMessage,
    NativeBalanceStatus? status,
    String? ticker,
  }) {
    return NativeBalanceState(
      isVisible: isVisible ?? this.isVisible,
      accountBalance: accountBalance ?? this.accountBalance,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      ticker: ticker ?? this.ticker,
    );
  }
}

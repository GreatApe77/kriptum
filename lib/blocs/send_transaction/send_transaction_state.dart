// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'send_transaction_bloc.dart';

enum SendTransactionStepStatus {
  chooseRecpient,
  selectAmount,
  toBeConfirmed,
}

enum SendTransactionStatus {
  confirmationIdle,
  confirmationLoading,
  confirmationSuccess,
  confirmationError
}

class SendTransactionState {
  final SendTransactionStepStatus sendTransactionStepStatus;
  final SendTransactionStatus status;
  final String? toAddress;
  final BigInt? amount;
  final String? txHash;
  final String? followOnBlockExplorerUrl;
  final String errorMessage;
  final bool toAddressEqualsCurrentAccount;

  SendTransactionState({
    required this.sendTransactionStepStatus,
    required this.toAddress,
    required this.amount,
    required this.txHash,
    required this.followOnBlockExplorerUrl,
    required this.errorMessage,
    required this.toAddressEqualsCurrentAccount,
    required this.status,
  });

  factory SendTransactionState.initial() {
    return SendTransactionState(
      sendTransactionStepStatus: SendTransactionStepStatus.chooseRecpient,
      toAddress: null,
      amount: null,
      txHash: null,
      followOnBlockExplorerUrl: null,
      errorMessage: '',
      toAddressEqualsCurrentAccount: false,
      status: SendTransactionStatus.confirmationIdle,
    );
  }
  SendTransactionState copyWith({
    SendTransactionStepStatus? sendTransactionStepStatus,
    String? toAddress,
    BigInt? amount,
    String? txHash,
    String? followOnBlockExplorerUrl,
    String? errorMessage,
    bool? toAddressEqualsCurrentAccount,
    SendTransactionStatus? status,
  }) {
    return SendTransactionState(
      sendTransactionStepStatus:
          sendTransactionStepStatus ?? this.sendTransactionStepStatus,
      toAddress: toAddress ?? this.toAddress,
      amount: amount ?? this.amount,
      txHash: txHash ?? this.txHash,
      followOnBlockExplorerUrl:
          followOnBlockExplorerUrl ?? this.followOnBlockExplorerUrl,
      errorMessage: errorMessage ?? this.errorMessage,
      toAddressEqualsCurrentAccount:
          toAddressEqualsCurrentAccount ?? this.toAddressEqualsCurrentAccount,
      status: status ?? this.status,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'import_token_bloc.dart';

enum ImportTokenStatus {
  initial,
  loading,
  success,
  failure,
}

enum FetchTokenInfoStatus {
  initial,
  loading,
  success,
  failure,
}

class ImportTokenState {
  final String tokenAddress;
  final String tokenSymbol;
  final String tokenName;
  final FetchTokenInfoStatus fetchTokenInfoStatus;
  final ImportTokenStatus importTokenStatus;
  final Exception error;
  final int tokenDecimals;

  ImportTokenState({
    required this.tokenAddress,
    required this.tokenSymbol,
    required this.tokenName,
    required this.tokenDecimals,
    required this.fetchTokenInfoStatus,
    required this.importTokenStatus,
    required this.error,
  });

  factory ImportTokenState.initial() {
    return ImportTokenState(
      tokenAddress: '',
      tokenSymbol: '',
      tokenName: '',
      tokenDecimals: 0,
      fetchTokenInfoStatus: FetchTokenInfoStatus.initial,
      importTokenStatus: ImportTokenStatus.initial,
      error: Exception(''),
    );
  }
  ImportTokenState copyWith({
    String? tokenAddress,
    String? tokenSymbol,
    String? tokenName,
    Exception? error,
    int? tokenDecimals,
    FetchTokenInfoStatus? fetchTokenInfoStatus,
    ImportTokenStatus? importTokenStatus,
  }) {
    return ImportTokenState(
      fetchTokenInfoStatus: fetchTokenInfoStatus ?? this.fetchTokenInfoStatus,
      importTokenStatus: importTokenStatus ?? this.importTokenStatus,
      error: error ?? this.error,
      tokenAddress: tokenAddress ?? this.tokenAddress,
      tokenSymbol: tokenSymbol ?? this.tokenSymbol,
      tokenName: tokenName ?? this.tokenName,
      tokenDecimals: tokenDecimals ?? this.tokenDecimals,
    );
  }
}

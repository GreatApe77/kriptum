import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/usecases/search_erc20_token_metadata_usecase.dart';

part 'import_token_event.dart';
part 'import_token_state.dart';

class ImportTokenBloc extends Bloc<ImportTokenEvent, ImportTokenState> {
  final SearchErc20TokenMetadataUsecase _searchErc20TokenMetadataUsecase;
  ImportTokenBloc(this._searchErc20TokenMetadataUsecase) : super(ImportTokenState.initial()) {
    on<ValidEthereumAddressInputed>(_onValidEthereumAddressInputed);
  }

  FutureOr<void> _onValidEthereumAddressInputed(
    ValidEthereumAddressInputed event,
    Emitter<ImportTokenState> emit,
  ) async {
    try {
      print(event.contractAddress);
      emit(
        state.copyWith(
          fetchTokenInfoStatus: FetchTokenInfoStatus.loading,
          tokenAddress: event.contractAddress,
        ),
      );
      final result = await _searchErc20TokenMetadataUsecase.execute(
        SearchErc20TokenMetadataInput(
          contractAddress: event.contractAddress,
        ),
      );
      print(result.name);
      emit(
        state.copyWith(
          tokenName: result.name,
          tokenAddress: event.contractAddress,
          tokenSymbol: result.symbol,
          tokenDecimals: result.decimals,
          fetchTokenInfoStatus: FetchTokenInfoStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchTokenInfoStatus: FetchTokenInfoStatus.failure,
          errorMessage: 'Could not load token metadata',
        ),
      );
    }
  }
}

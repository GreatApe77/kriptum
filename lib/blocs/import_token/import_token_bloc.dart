import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/usecases/import_erc20_token_usecase.dart';
import 'package:kriptum/domain/usecases/search_erc20_token_metadata_usecase.dart';

part 'import_token_event.dart';
part 'import_token_state.dart';

class ImportTokenBloc extends Bloc<ImportTokenEvent, ImportTokenState> {
  final SearchErc20TokenMetadataUsecase _searchErc20TokenMetadataUsecase;
  final ImportErc20TokenUsecase _importErc20TokenUsecase;
  ImportTokenBloc(this._searchErc20TokenMetadataUsecase, this._importErc20TokenUsecase)
      : super(ImportTokenState.initial()) {
    on<ValidEthereumAddressInputed>(_onValidEthereumAddressInputed);
    on<ImportTokenSubmitted>(_onImportTokenSubmitted);
  }

  FutureOr<void> _onValidEthereumAddressInputed(
    ValidEthereumAddressInputed event,
    Emitter<ImportTokenState> emit,
  ) async {
    try {
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
      emit(
        state.copyWith(
          tokenName: result.name,
          tokenAddress: event.contractAddress,
          tokenSymbol: result.symbol,
          tokenDecimals: result.decimals,
          fetchTokenInfoStatus: FetchTokenInfoStatus.success,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          fetchTokenInfoStatus: FetchTokenInfoStatus.failure,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchTokenInfoStatus: FetchTokenInfoStatus.failure,
          error: Exception('Unknown error occurred while fetching token info'),
        ),
      );
    }
  }

  FutureOr<void> _onImportTokenSubmitted(ImportTokenSubmitted event, Emitter<ImportTokenState> emit) async {
    try {
      emit(
        state.copyWith(
          importTokenStatus: ImportTokenStatus.loading,
        ),
      );
      await _importErc20TokenUsecase.execute(
        ImportErc20TokenInput(
          contractAddress: state.tokenAddress,
          name: state.tokenName,
          symbol: state.tokenSymbol,
          decimals: state.tokenDecimals,
        ),
      );
      emit(
        state.copyWith(
          importTokenStatus: ImportTokenStatus.success,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          importTokenStatus: ImportTokenStatus.failure,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          importTokenStatus: ImportTokenStatus.failure,
          error: Exception('Could not import token'),
        ),
      );
    }
  }
}

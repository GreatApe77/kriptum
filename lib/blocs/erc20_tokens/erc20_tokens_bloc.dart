import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/models/erc20_token.dart';
import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/repositories/erc20_token_repository.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/domain/usecases/get_erc20_balances_usecase.dart';

part 'erc20_tokens_event.dart';
part 'erc20_tokens_state.dart';

class Erc20TokensBloc extends Bloc<Erc20TokensEvent, Erc20TokensState> {
  final Erc20TokenRepository _erc20tokenRepository;
  final NetworksRepository _networksRepository;
  final GetErc20BalancesUsecase _getErc20BalancesUsecase;
  Erc20TokensBloc(
    this._erc20tokenRepository,
    this._networksRepository,
    this._getErc20BalancesUsecase,
  ) : super(Erc20TokensState.initial()) {
    on<Erc20TokensLoadRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: Erc20TokensStatus.loading));
        final network = await _networksRepository.getCurrentNetwork();
        final tokens = await _erc20tokenRepository.getAllImportedTokensOfNetwork(network.id!);
        final result = await _getErc20BalancesUsecase.execute();
        final tokensWithBalances = tokens.map(
          (e) {
            return Erc20TokenWithBalance(
              balance: result.balanceOf[e.address] ?? EtherAmount.fromString(value: '0'),
              token: e,
            );
          },
        ).toList();
        emit(
          state.copyWith(
            status: Erc20TokensStatus.loaded,
            tokens: tokensWithBalances,
          ),
        );
      } on DomainException catch (e) {
        emit(state.copyWith(
          status: Erc20TokensStatus.error,
          errorMessage: e.getReason(),
        ));
      } catch (e) {
        emit(state.copyWith(
          status: Erc20TokensStatus.error,
          errorMessage: 'Error loading tokens',
        ));
      }
    });
  }
}

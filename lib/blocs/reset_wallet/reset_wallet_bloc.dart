import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/usecases/reset_wallet_usecase.dart';

part 'reset_wallet_event.dart';
part 'reset_wallet_state.dart';

class ResetWalletBloc extends Bloc<ResetWalletEvent, ResetWalletState> {
  final ResetWalletUsecase _resetWalletUsecase;
  ResetWalletBloc({
    required ResetWalletUsecase resetWalletUsecase,
  })  : _resetWalletUsecase = resetWalletUsecase,
        super(ResetWalletInitial()) {
    on<ResetWalletRequested>((event, emit) async {
      try {
        emit(ResetWalletInProgress());
        await _resetWalletUsecase.execute();
        emit(ResetWalletSuccess());
      } catch (e) {
        emit(ResetWalletFailure('Failed to reset wallet'));
      }
    });
  }
}

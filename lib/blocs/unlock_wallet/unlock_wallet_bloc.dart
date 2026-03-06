import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/usecases/unlock_wallet_usecase.dart';

part 'unlock_wallet_event.dart';
part 'unlock_wallet_state.dart';

class UnlockWalletBloc extends Bloc<UnlockWalletEvent, UnlockWalletState> {
  final UnlockWalletUsecase _unlockWalletUsecase;

  UnlockWalletBloc({
    required UnlockWalletUsecase unlockWalletUsecase,
  })  : _unlockWalletUsecase = unlockWalletUsecase,
        super(UnlockWalletInitial()) {
    on<UnlockWalletRequested>((event, emit) async {
      try {
        emit(UnlockWalletInProgress());
        await _unlockWalletUsecase.execute(event.password);
        emit(UnlockWalletSuccess());
      } on Exception catch (e) {
        emit(UnlockWalletFailure(error: e));
      } catch (e) {
        emit(UnlockWalletFailure(error: Exception('Failed to unlock wallet')));
      }
    });
  }
}

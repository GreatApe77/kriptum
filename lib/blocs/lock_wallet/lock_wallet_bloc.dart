import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/usecases/lock_wallet_usecase.dart';

part 'lock_wallet_event.dart';
part 'lock_wallet_state.dart';

class LockWalletBloc extends Bloc<LockWalletEvent, LockWalletState> {
  final LockWalletUsecase _lockWalletUsecase;
  LockWalletBloc(this._lockWalletUsecase) : super(LockWalletInitial()) {
    on<LockWalletRequested>(
      (event, emit) async {
        try {
          await _lockWalletUsecase.execute();
          emit(LockWalletSuccess());
        } catch (e) {
          emit(
            LockWalletError(errorMessage: 'Could not Lock Wallet'),
          );
        }
      },
    );
  }
}

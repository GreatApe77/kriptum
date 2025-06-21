import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/usecases/import_wallet_usecase.dart';

part 'import_wallet_event.dart';
part 'import_wallet_state.dart';

class ImportWalletBloc extends Bloc<ImportWalletEvent, ImportWalletState> {
  final ImportWalletUsecase _importWalletUsecase;
  ImportWalletBloc(this._importWalletUsecase) : super(ImportWalletInitial()) {
    on<ImportWalletRequested>(
      (event, emit) async {
        try {
          emit(ImportWalletLoading());
          final params = ImportWalletUsecaseParams(
            mnemonic: event.mnemonicPhrase,
            encryptionPassword: event.password,
          );
          await _importWalletUsecase.execute(params);
          emit(ImportWalletSuccess());
        } catch (e) {
          emit(
            ImportWalletFailed(reason: 'Failed to import Wallet'),
          );
        }
      },
    );
  }
}

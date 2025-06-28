import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/usecases/add_hd_wallet_account_usecase.dart';

part 'add_hd_wallet_account_event.dart';
part 'add_hd_wallet_account_state.dart';

class AddHdWalletAccountBloc extends Bloc<AddHdWalletAccountEvent, AddHdWalletAccountState> {
  final AddHdWalletAccountUsecase _usecase;
  AddHdWalletAccountBloc(this._usecase) : super(AddHdWalletAccountInitial()) {
    on<AddHdWalletAccountRequested>(
      (event, emit) async {
        try {
          emit(AddHdWalletAccountLoading());
          await _usecase.execute();
          emit(AddHdWalletAccountSuccess());
        } on DomainException catch (e) {
          print(e.getReason());
          emit(
            AddHdWalletAccountError(
              message: e.getReason(),
            ),
          );
        } catch (e) {
          print(e);
          emit(
            AddHdWalletAccountError(message: 'Could not add Wallet'),
          );
        }
      },
    );
  }
}

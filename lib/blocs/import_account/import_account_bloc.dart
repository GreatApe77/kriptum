import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/usecases/import_account_from_private_key_usecase.dart';

part 'import_account_event.dart';
part 'import_account_state.dart';

class ImportAccountBloc extends Bloc<ImportAccountEvent, ImportAccountState> {
  final ImportAccountFromPrivateKeyUsecase _importAccountFromPrivateKeyUsecase;
  ImportAccountBloc(this._importAccountFromPrivateKeyUsecase) : super(ImportAccountInitial()) {
    on<ImportAccountRequested>((event, emit) async {
      try {
        emit(ImportAccountLoading());
        await _importAccountFromPrivateKeyUsecase.execute(
          ImportAccountFromPrivateKeyInput(privateKey: event.privateKey),
        );
        emit(ImportAccountSuccess());
      } on DomainException catch (e) {
        emit(ImportAccountFailed(errorMessage: e.getReason()));
      } catch (e) {
        emit(ImportAccountFailed(errorMessage: 'Failed to Import Account'));
      }
    });
  }
}

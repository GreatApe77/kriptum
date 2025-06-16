import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';
import 'package:kriptum/domain/usecases/confirm_and_save_generated_accounts_usecase.dart';
import 'package:kriptum/domain/usecases/generate_accounts_preview_usecase.dart';

part 'create_new_wallet_event.dart';
part 'create_new_wallet_state.dart';

class CreateNewWalletBloc
    extends Bloc<CreateNewWalletEvent, CreateNewWalletState> {
  final GenerateAccountsPreviewUsecase _generateAccountsPreviewUsecase;
  final ConfirmAndSaveGeneratedAccountsUsecase
      _confirmAndSaveGeneratedAccountsUsecase;
  final AccountGeneratorService _accountGeneratorService;

  CreateNewWalletBloc({
    required GenerateAccountsPreviewUsecase generateAccountsPreviewUsecase,
    required ConfirmAndSaveGeneratedAccountsUsecase
        confirmAndSaveGeneratedAccountsUsecase,
    required AccountGeneratorService accountGeneratorService,
  })  : _generateAccountsPreviewUsecase = generateAccountsPreviewUsecase,
        _confirmAndSaveGeneratedAccountsUsecase =
            confirmAndSaveGeneratedAccountsUsecase,
        _accountGeneratorService = accountGeneratorService,
        super(
          CreateNewWalletState.initial(),
        ) {
    on<CreateNewWalletEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AdvanceToStep2Event>((event, emit) {
      emit(
        state.copyWith(
          step: 2,
        ),
      );
    });
    on<AdvanceToStep3Event>((event, emit) {
      emit(
        state.copyWith(
          step: 3,
        ),
      );
    });
  }
}

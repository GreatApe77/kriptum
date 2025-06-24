import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account.dart';
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
    on<PasswordChangedEvent>((event, emit) {
      emit(
        state.copyWith(
          password: event.password,
        ),
      );
    });
    on<ConfirmPasswordChangedEvent>((event, emit) {
      emit(
        state.copyWith(
          confirmPassword: event.confirmPassword,
        ),
      );
    });
    on<AdvanceToStep2Event>((event, emit) async {
      if (state.password.isEmpty ||
          state.confirmPassword.isEmpty ||
          state.password != state.confirmPassword) {
        emit(
          state.copyWith(
            errorMessage: 'Passwords do not match or are empty.',
            status: CreateNewWalletStatus.failure,
          ),
        );
        return;
      }

      try {
        emit(state.copyWith(
          status: CreateNewWalletStatus.loading,
        ));
        final mnemonic = _accountGeneratorService.generateMnemonic();
        final accounts = await _generateAccountsPreviewUsecase
            .execute(GenerateAccountsPreviewUsecaseParams(
          password: state.password,
          mnemonic: mnemonic,
        ));

        emit(state.copyWith(
          accounts: accounts,
          mnemonic: mnemonic,
          step: 2,
          status: CreateNewWalletStatus.success,
          errorMessage: '',
        ));
      } catch (e) {
        emit(
          state.copyWith(
            errorMessage: 'Failed to generate accounts: $e',
            status: CreateNewWalletStatus.failure,
          ),
        );
      }
    });
    on<AdvanceToStep3Event>((event, emit) {
      emit(
        state.copyWith(
          step: 3,
        ),
      );
    });
    on<ConfirmBackupEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: CreateNewWalletStatus.loading,
          ),
        );
        await _confirmAndSaveGeneratedAccountsUsecase.execute(
          state.accounts,
          state.mnemonic,
        );
        emit(
          state.copyWith(
            status: CreateNewWalletStatus.success,
            errorMessage: '',
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: CreateNewWalletStatus.failure,
            errorMessage: 'Failed to save accounts: $e',
          ),
        );
      }
    });
  }
}

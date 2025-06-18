import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/usecases/get_native_balance_of_account_usecase.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';

part 'native_balance_event.dart';
part 'native_balance_state.dart';

class NativeBalanceBloc extends Bloc<NativeBalanceEvent, NativeBalanceState> {
  final UserPreferences _userPreferences;
  final GetNativeBalanceOfAccountUsecase _getNativeBalanceOfAccountUsecase;
  NativeBalanceBloc(
      this._getNativeBalanceOfAccountUsecase, this._userPreferences)
      : super(NativeBalanceState.initial()) {
    on<NativeBalanceVisibilityRequested>(
      (event, emit) async {
        final isVisible = await _userPreferences.isNativeBalanceVisible();
        emit(
          state.copyWith(
            isVisible: isVisible,
          ),
        );
      },
    );
    on<ToggleNativeBalanceVisibility>(
      (event, emit) async {
        emit(
          state.copyWith(
            isVisible: event.isVisible,
          ),
        );
        await _userPreferences.setNativeBalanceVisibility(event.isVisible);
      },
    );
    on<NativeBalanceRequested>((event, emit) async {
      emit(state.copyWith(status: NativeBalanceStatus.loading));
      try {
        await Future.delayed(const Duration(seconds: 1));
        final accountBalance =
            await _getNativeBalanceOfAccountUsecase.execute();
        emit(
          state.copyWith(
            accountBalance: accountBalance,
            status: NativeBalanceStatus.loaded,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            errorMessage: 'Failed to load native balance',
            status: NativeBalanceStatus.error,
          ),
        );
      }
    });
  }
}

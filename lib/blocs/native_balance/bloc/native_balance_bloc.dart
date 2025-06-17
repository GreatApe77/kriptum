import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/usecases/get_native_balance_of_account_usecase.dart';

part 'native_balance_event.dart';
part 'native_balance_state.dart';

class NativeBalanceBloc extends Bloc<NativeBalanceEvent, NativeBalanceState> {
  //final GetNativeBalanceOfAccountUsecase getNativeBalanceOfAccountUsecase;
  NativeBalanceBloc(
      //this.getNativeBalanceOfAccountUsecase
      )
      : super(NativeBalanceInitial()) {
    on<NativeBalanceRequested>((event, emit) async {
      emit(NativeBalanceLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        //final accountBalance = await getNativeBalanceOfAccountUsecase.execute();
        emit(
          NativeBalanceLoaded(
            accountBalance: AccountBalance(
              BigInt.parse('5000000000000000000'), // Example balance
            ),
          ),
        );
      } catch (e) {
        emit(NativeBalanceError(errorMessage: 'Failed to load native balance'));
      }
    });
  }
}

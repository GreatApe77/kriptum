import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/usecases/get_native_balance_of_account_usecase.dart';
import 'package:kriptum/shared/utils/convert_string_eth_to_wei.dart';

part 'send_transaction_event.dart';
part 'send_transaction_state.dart';

class SendTransactionBloc
    extends Bloc<SendTransactionEvent, SendTransactionState> {
  final AccountsRepository _accountsRepository;
  final GetNativeBalanceOfAccountUsecase _getNativeBalanceOfAccountUsecase;
  SendTransactionBloc(
      this._accountsRepository, this._getNativeBalanceOfAccountUsecase)
      : super(SendTransactionState.initial()) {
    on<ToAddressChanged>((event, emit) async {
      final currentAccount = await _accountsRepository.getCurrentAccount();
      emit(
        state.copyWith(
          toAddressEqualsCurrentAccount:
              currentAccount?.address == event.toAddress,
        ),
      );
    });
    on<ReturnToAmountSelection>((event, emit) {
      emit(
        state.copyWith(
          sendTransactionStepStatus: SendTransactionStepStatus.selectAmount,
        ),
      );
    });
    on<ReturnToRecipientSelection>(
      (event, emit) {
        emit(
          state.copyWith(
            sendTransactionStepStatus: SendTransactionStepStatus.chooseRecpient,
          ),
        );
      },
    );
    on<AdvanceToAmountSelection>(
      (event, emit) {
        emit(
          state.copyWith(
            sendTransactionStepStatus: SendTransactionStepStatus.selectAmount,
            toAddress: event.toAddress,
          ),
        );
      },
    );
    on<AdvanceToConfirmation>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              errorMessage: '',
            ),
          );
          final bigintAmount = convertStringEthToWei(event.amount);
          final amount = AccountBalance(valueInWei: bigintAmount);
          final currentBalance =
              await _getNativeBalanceOfAccountUsecase.execute();
          if (amount.valueInWei > currentBalance.valueInWei) {
            emit(
              state.copyWith(errorMessage: 'Not enough balance'),
            );
            return;
          }
          emit(
            state.copyWith(
              amount: bigintAmount,
              sendTransactionStepStatus:
                  SendTransactionStepStatus.toBeConfirmed,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(errorMessage: 'Unknown error'),
          );
        }
      },
    );
  }
}

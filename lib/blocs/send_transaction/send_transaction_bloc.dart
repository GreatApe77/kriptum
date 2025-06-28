import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/usecases/get_native_balance_of_account_usecase.dart';
import 'package:kriptum/shared/utils/convert_string_eth_to_wei.dart';

part 'send_transaction_event.dart';
part 'send_transaction_state.dart';

class SendTransactionBloc extends Bloc<SendTransactionEvent, SendTransactionState> {
  final AccountsRepository _accountsRepository;
  final GetNativeBalanceOfAccountUsecase _getNativeBalanceOfAccountUsecase;
  final SendTransactionBloc _sendTransactionBloc;
  SendTransactionBloc(
    this._accountsRepository,
    this._getNativeBalanceOfAccountUsecase,
    this._sendTransactionBloc,
  ) : super(SendTransactionState.initial()) {
    on<ToAddressChanged>(_onToAddressChanged);
    on<ReturnToAmountSelection>(_onReturnToAmountSelection);
    on<ReturnToRecipientSelection>(_onReturnToRecipientSelection);
    on<AdvanceToAmountSelection>(_onAdvanceToAmountSelection);
    on<AdvanceToConfirmation>(_onAdvanceToConfirmation);
  }

  Future<void> _onToAddressChanged(
    ToAddressChanged event,
    Emitter<SendTransactionState> emit,
  ) async {
    final currentAccount = await _accountsRepository.getCurrentAccount();
    emit(
      state.copyWith(
        toAddressEqualsCurrentAccount: currentAccount?.address == event.toAddress,
      ),
    );
  }

  void _onReturnToAmountSelection(
    ReturnToAmountSelection event,
    Emitter<SendTransactionState> emit,
  ) {
    emit(
      state.copyWith(
        sendTransactionStepStatus: SendTransactionStepStatus.selectAmount,
      ),
    );
  }

  void _onReturnToRecipientSelection(
    ReturnToRecipientSelection event,
    Emitter<SendTransactionState> emit,
  ) {
    emit(
      state.copyWith(
        sendTransactionStepStatus: SendTransactionStepStatus.chooseRecpient,
      ),
    );
  }

  void _onAdvanceToAmountSelection(
    AdvanceToAmountSelection event,
    Emitter<SendTransactionState> emit,
  ) {
    emit(
      state.copyWith(
        sendTransactionStepStatus: SendTransactionStepStatus.selectAmount,
        toAddress: event.toAddress,
      ),
    );
  }

  Future<void> _onAdvanceToConfirmation(
    AdvanceToConfirmation event,
    Emitter<SendTransactionState> emit,
  ) async {
    try {
      emit(state.copyWith(errorMessage: ''));

      final bigintAmount = convertStringEthToWei(event.amount);
      final amount = AccountBalance(valueInWei: bigintAmount);
      final currentBalance = await _getNativeBalanceOfAccountUsecase.execute();

      if (amount.valueInWei > currentBalance.valueInWei) {
        emit(state.copyWith(errorMessage: 'Not enough balance'));
        return;
      }

      emit(
        state.copyWith(
          amount: bigintAmount,
          sendTransactionStepStatus: SendTransactionStepStatus.toBeConfirmed,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Unknown error'));
    }
  }
}

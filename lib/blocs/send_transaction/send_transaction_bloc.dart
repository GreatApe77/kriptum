import 'package:bloc/bloc.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/shared/utils/convert_string_eth_to_wei.dart';

part 'send_transaction_event.dart';
part 'send_transaction_state.dart';

class SendTransactionBloc
    extends Bloc<SendTransactionEvent, SendTransactionState> {
  final AccountsRepository _accountsRepository;
  SendTransactionBloc(this._accountsRepository)
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
      (event, emit) {
        try {
          //TODO: VALIDATE IF AMOUNT IS GREATER THAN CURRENT BALANCE
          final bigintAmount = convertStringEthToWei(event.amount);
          emit(
            state.copyWith(
              amount: bigintAmount,
              sendTransactionStepStatus:
                  SendTransactionStepStatus.toBeConfirmed,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(errorMessage: 'Invalid amount'),
          );
        }
      },
    );
  }
}

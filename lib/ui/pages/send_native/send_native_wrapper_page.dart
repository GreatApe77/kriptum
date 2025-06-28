import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/send_transaction/send_transaction_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/pages/send_native/widgets/choose_amount_widget.dart';
import 'package:kriptum/ui/pages/send_native/widgets/choose_recipient_widget.dart';
import 'package:kriptum/ui/pages/send_native/widgets/confirm_transaction_widget.dart';

class SendNativeWrapperPage extends StatelessWidget {
  const SendNativeWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendTransactionBloc>(
      create: (context) => SendTransactionBloc(
        injector.get(),
        injector.get(),
      ),
      child: _SendNativeWrapperPage(),
    );
  }
}

class _SendNativeWrapperPage extends StatelessWidget {
  const _SendNativeWrapperPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendTransactionBloc, SendTransactionState>(
      buildWhen: (previous, current) =>
          previous.sendTransactionStepStatus !=
          current.sendTransactionStepStatus,
      builder: (context, state) {
        final status = state.sendTransactionStepStatus;
        final bloc = context.read<SendTransactionBloc>();
        switch (status) {
          case SendTransactionStepStatus.chooseRecpient:
            return BlocProvider<SendTransactionBloc>.value(
              value: bloc,
              child: const ChooseRecipientWidget(),
            );

          case SendTransactionStepStatus.selectAmount:
            return BlocProvider<SendTransactionBloc>.value(
              value: bloc,
              child: const ChooseAmountWidget(),
            );
          case SendTransactionStepStatus.toBeConfirmed:
            return BlocProvider<SendTransactionBloc>.value(
              value: bloc,
              child: const ConfirmTransactionWidget(),
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}

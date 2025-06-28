import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/blocs/current_account/current_account_cubit.dart';
import 'package:kriptum/blocs/current_network/current_network_cubit.dart';
import 'package:kriptum/blocs/native_balance/native_balance_bloc.dart';
import 'package:kriptum/blocs/send_transaction/send_transaction_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/shared/utils/format_address.dart';
import 'package:kriptum/ui/pages/send_native/widgets/page_title.dart';
import 'package:kriptum/ui/tokens/spacings.dart';

class ConfirmTransactionWidget extends StatelessWidget {
  const ConfirmTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NativeBalanceBloc>(
          create: (context) => NativeBalanceBloc(
            injector.get(),
            injector.get(),
            injector.get(),
            injector.get(),
          )..add(NativeBalanceRequested()),
        ),
        BlocProvider<CurrentNetworkCubit>(
          create: (context) => CurrentNetworkCubit(injector.get())..requestCurrentNetwork(),
        ),
        BlocProvider<CurrentAccountCubit>(
          create: (context) => CurrentAccountCubit(injector.get())..requestCurrentAccount(),
        ),
      ],
      child: _ConfirmTransactionWidget(),
    );
  }
}

class _ConfirmTransactionWidget extends StatelessWidget {
  const _ConfirmTransactionWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            context.read<SendTransactionBloc>().add(ReturnToAmountSelection());
          },
          child: const Text('Back'),
        ),
        title: PageTitle(
          title: 'Confirm',
          networkName: '',
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                //GoRouter.of(context).pushReplacement(AppRoutes.home);
              },
              child: const Text('Cancel'),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacings.horizontalPadding,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'From:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ListTile(
                    // shape: Border.all(

                    //   color: Theme.of(context).hintColor
                    // ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Theme.of(context).hintColor),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    trailing: Builder(builder: (context) {
                      final balanceBloc = context.watch<NativeBalanceBloc>();
                      final networksCubit = context.watch<CurrentNetworkCubit>();
                      final balance = balanceBloc.state.accountBalance;
                      final networkState = networksCubit.state;
                      String ticker = '';
                      if (networkState is CurrentNetworkLoaded) {
                        ticker = networkState.network.ticker;
                      }
                      if (ticker.isEmpty || balance == null) return SizedBox.shrink();
                      return Text(
                          //'${formatEther(accountBalanceController.balance)} ${currentNetworkController.currentConnectedNetwork?.ticker}',
                          '${balance.toReadableString()} $ticker',
                          style: Theme.of(context).textTheme.bodyLarge);
                    }),
                    leading: BlocBuilder<CurrentAccountCubit, CurrentAccountState>(
                      builder: (context, state) {
                        if (state.account == null) return SizedBox.shrink();
                        return Jazzicon.getIconWidget(
                          size: 30,
                          Jazzicon.getJazziconData(
                            30,
                            address: state.account?.address,
                          ),
                        );
                      },
                    ),
                    title: BlocBuilder<CurrentAccountCubit, CurrentAccountState>(
                      builder: (context, state) {
                        if (state.account == null) return SizedBox.shrink();
                        return Text(
                          state.account!.alias ?? 'From',
                        );
                      },
                    ),
                    subtitle: BlocBuilder<CurrentAccountCubit, CurrentAccountState>(
                      builder: (context, state) {
                        if (state.account == null) return SizedBox.shrink();
                        return Text(
                          formatAddress(state.account!.address),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'To',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  BlocSelector<SendTransactionBloc, SendTransactionState, String?>(
                    selector: (state) {
                      return state.toAddress;
                    },
                    builder: (context, state) {
                      return ListTile(
                        title: Text(
                          formatAddress(state!),
                        ),
                        // shape: Border.all(

                        //   color: Theme.of(context).hintColor
                        // ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Theme.of(context).hintColor),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        leading: Jazzicon.getIconWidget(
                          size: 30,
                          Jazzicon.getJazziconData(
                            30,
                            address: state,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              Expanded(
                  child: ListView(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'AMOUNT',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Builder(builder: (context) {
                    final amount = context.select<SendTransactionBloc, BigInt?>((bloc) => bloc.state.amount);
                    final currentNetworkCubit = context.watch<CurrentNetworkCubit>();
                    String ticker = '';
                    final networkState = currentNetworkCubit.state;
                    if (networkState is CurrentNetworkLoaded) {
                      ticker = networkState.network.ticker;
                    }
                    if (ticker.isEmpty || amount == null) {
                      return SizedBox.shrink();
                    }

                    return Text(
                      '${AccountBalance(valueInWei: amount).toReadableString()} \n $ticker',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    );
                  })
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    onPressed: () {},
                    child: Text('Send'),
                  )
                  //onPressed: sendTransactionController.isLoading
                  //    ? null
                  //    : () => _triggerSendTransaction(context),
                  //child: Text(sendTransactionController.isLoading
                  //    ? 'Submitting Transaction'
                  //   : 'Send'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _triggerSendTransaction(BuildContext context) async {
    /*  await sendTransactionController.sendTransaction(
      connectedAccount: currentAccountController.connectedAccount!,
      connectedNetwork: currentNetworkController.currentConnectedNetwork!,
      password: locator.get<PasswordController>().password,
      to: toAddressController.toAddress,
      amountInWei: sendAmountController.amount,
      onSuccess: (transactionHash) async {
        // Use context before navigation
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          //..showSnackBar(buildWaitngTransactionSnackBar(context))
          ..showSnackBar(buildSubmittedTransactionSnackBar(
            context,
            (dialogContext) {
              showDialog(
                context: navigatorKey.currentContext!,
                builder: (context) => TransactionInfoDialog(
                  dateTime: DateTime.now(),
                  network: currentNetworkController.currentConnectedNetwork!,
                  from: currentAccountController.connectedAccount!,
                  toAddress: toAddressController.toAddress,
                  transactionHash: transactionHash,
                  amount: sendAmountController.amount,
                ),
              );
            },
          ));
        // Navigate after showing SnackBars
        GoRouter.of(context).pushReplacement(AppRoutes.home);
      },
      onFail: () {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('Something went wrong'),
          ));
      },
    );
  } */
  }
}

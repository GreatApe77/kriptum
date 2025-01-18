import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/send/send_amount_controller.dart';
import 'package:kriptum/controllers/send/send_transaction_controller.dart';
import 'package:kriptum/controllers/send/to_address_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/controllers/balance_validator_controller.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/views/send/screens/confirm_screen.dart';
import 'package:kriptum/ui/views/send/widgets/page_title.dart';

class AmountScreen extends StatelessWidget {
  final TextEditingController amountTextEditingController =
      TextEditingController();
  final AccountBalanceController accountBalanceController;
  final CurrentNetworkController currentNetworkController;
  final SendAmountController sendAmountController;
  final CurrentAccountController currentAccountController;
  final ToAddressController toAddressController;
  final SendTransactionController sendTransactionController;
  AmountScreen(
      {super.key,
      required this.accountBalanceController,
      required this.currentNetworkController,
      required this.sendAmountController,
      required this.currentAccountController,
      required this.toAddressController, required this.sendTransactionController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
            title: 'Amount',
            networkName:
                currentNetworkController.currentConnectedNetwork!.name),
        centerTitle: true,
        leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Back')),
        actions: [
          TextButton(
              onPressed: () {},
              child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRoutes.home);
                  },
                  child: const Text('Cancel')))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      label: Text(
                          '${currentNetworkController.currentConnectedNetwork?.name} ${currentNetworkController.currentConnectedNetwork?.ticker}')),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => _useMax(), child: const Text('USE MAX')))
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            TextField(
              controller: amountTextEditingController,
              onChanged: (value) {
                sendAmountController.updateAmountValueInEth(value);
              },
              keyboardType: const TextInputType.numberWithOptions(),
              style: const TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
              decoration:
                  const InputDecoration(hintText: '0', border: InputBorder.none),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
                'Balance: ${formatEther(accountBalanceController.balance)} ${currentNetworkController.currentConnectedNetwork?.ticker}'),
            Expanded(child: Container()),
            Padding(
              padding: AppSpacings.horizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                      onPressed: () => _onNextStep(context),
                      child: const Text('Next')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _useMax(){
    amountTextEditingController.text = formatEther(accountBalanceController.balance);
    sendAmountController.updateAmountValueInEth(amountTextEditingController.text);
  }
  void _onNextStep(BuildContext context) {
    if (!BalanceValidatorController.validateBalance(
        amountTextEditingController.text, accountBalanceController.balance)) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(

           SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            showCloseIcon: true,
            content: const Text('Amount must not exceed account balance!')));

            return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ConfirmScreen(
        sendTransactionController: sendTransactionController,
        toAddressController: toAddressController,
        accountBalanceController: accountBalanceController,
        currentAccountController: currentAccountController,
        currentNetworkController: currentNetworkController,
        sendAmountController: sendAmountController,
      ),
    ));
  }
}

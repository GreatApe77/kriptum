import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/send/send_amount_controller.dart';
import 'package:kriptum/controllers/send/to_address_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/views/send/widgets/page_title.dart';

class ConfirmScreen extends StatelessWidget {
  final CurrentNetworkController currentNetworkController;
  final SendAmountController sendAmountController;
  final CurrentAccountController currentAccountController;
  final AccountBalanceController accountBalanceController;
  final ToAddressController toAddressController;
  const ConfirmScreen(
      {super.key,
      required this.currentNetworkController,
      required this.sendAmountController,
      required this.currentAccountController,
      required this.accountBalanceController,
      required this.toAddressController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Back'),
        ),
        title: PageTitle(
            title: 'Confirm',
            networkName:
                currentNetworkController.currentConnectedNetwork!.name),
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
          child: Padding(
        padding: AppSpacings.horizontalPadding,
        child: Column(
          children: [
            SizedBox(
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
                      side: BorderSide(
                          width: 1, color: Theme.of(context).hintColor),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  trailing: Text(
                      '${formatEther(accountBalanceController.balance)} ${currentNetworkController.currentConnectedNetwork?.ticker}',
                      style: Theme.of(context).textTheme.bodyLarge),
                  leading: Jazzicon.getIconWidget(
                    size: 30,
                    Jazzicon.getJazziconData(30,
                        address:
                            currentAccountController.connectedAccount?.address),
                  ),
                  title: Text(
                    'Account ${currentAccountController.connectedAccount!.accountIndex + 1}',
                  ),
                  subtitle: Text('${formatAddress(
                    currentAccountController.connectedAccount!.address,
                  )} '),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'To',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ListTile(
                    title: Text(formatAddress(toAddressController.toAddress)),
                    // shape: Border.all(

                    //   color: Theme.of(context).hintColor
                    // ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1, color: Theme.of(context).hintColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    leading: Jazzicon.getIconWidget(
                      size: 30,
                      Jazzicon.getJazziconData(30,
                          address: toAddressController.toAddress),
                    ))
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  'AMOUNT',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 24,
                ),
                Text('${formatEther(sendAmountController.amount)}\n${currentNetworkController.currentConnectedNetwork?.ticker}',textAlign: TextAlign.center,style: Theme.of(context).textTheme.displayMedium,)
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [ElevatedButton(onPressed: () {}, child: Text('Send'))],
            )
          ],
        ),
      )),
    );
  }
}

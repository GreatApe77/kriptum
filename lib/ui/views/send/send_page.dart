// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/accounts_controller.dart';
import 'package:kriptum/controllers/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/send/send_amount_controller.dart';
import 'package:kriptum/controllers/send/to_address_controller.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/shared/widgets/account_tile.dart';
import 'package:kriptum/ui/views/send/screens/amount_screen.dart';
import 'package:kriptum/ui/views/send/widgets/page_title.dart';

class SendPage extends StatelessWidget {
  final CurrentAccountController currentAccountController;
  final AccountBalanceController accountBalanceController;
  final AccountsController accountsController;
  final CurrentNetworkController currentNetworkController;
  final SendAmountController sendAmountController;
  final ToAddressController toAddressController;
  const SendPage(
      {super.key,
      required this.currentAccountController,
      required this.accountsController,
      required this.currentNetworkController,
      required this.accountBalanceController,
      required this.sendAmountController,
      required this.toAddressController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'))
        ],
        title: PageTitle(
          title: 'Send to',
          networkName: currentNetworkController.currentConnectedNetwork!.name,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacings.horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'From: ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                              'Account ${currentAccountController.connectedAccount!.accountIndex + 1}'),
                          subtitle: Text(
                              'Balance: ${formatEther(accountBalanceController.balance)} ${currentNetworkController.currentConnectedNetwork?.ticker}'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'To: ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Flexible(
                          child: TextFormField(
                        onChanged: (value) {
                          toAddressController.setToAddress(value);
                        },
                        decoration: const InputDecoration(
                            label: Text('Ethereum Address'),
                            border: OutlineInputBorder()),
                      ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Your Accounts',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: accountsController.accounts.length,
                itemBuilder: (context, index) => AccountTile(
                    onSelected: () {},
                    account: accountsController.accounts[index]),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AmountScreen(
                              toAddressController: toAddressController,
                              currentAccountController:
                                  currentAccountController,
                              sendAmountController: sendAmountController,
                              accountBalanceController:
                                  accountBalanceController,
                              currentNetworkController:
                                  currentNetworkController),
                        ));
                      },
                      child: const Text('Next')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/accounts_controller.dart';
import 'package:kriptum/controllers/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
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
  const SendPage(
      {super.key,
      required this.currentAccountController,
      required this.accountsController,
      required this.currentNetworkController,
      required this.accountBalanceController});

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
              child: Text('Cancel'))
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
                      Text(
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
                      Text(
                        'To: ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Flexible(
                          child: TextFormField(
                        decoration: InputDecoration(
                            label: Text('Ethereum Address'),
                            border: OutlineInputBorder()),
                      ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Your Accounts',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
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
                              accountBalanceController:
                                  accountBalanceController,
                              currentNetworkController:
                                  currentNetworkController),
                        ));
                      },
                      child: Text('Next')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

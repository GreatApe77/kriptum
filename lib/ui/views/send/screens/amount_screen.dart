import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/views/send/screens/confirm_screen.dart';
import 'package:kriptum/ui/views/send/send_page.dart';
import 'package:kriptum/ui/views/send/widgets/page_title.dart';

class AmountScreen extends StatelessWidget {
  final AccountBalanceController accountBalanceController;
  final CurrentNetworkController currentNetworkController;

  const AmountScreen(
      {super.key,
      required this.accountBalanceController,
      required this.currentNetworkController});

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
            child: Text('Back')),
        actions: [
          TextButton(
              onPressed: () {},
              child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRoutes.home);
                  },
                  child: Text('Cancel')))
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
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      label: Text(
                          '${currentNetworkController.currentConnectedNetwork?.name} ${currentNetworkController.currentConnectedNetwork?.ticker}')),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: const Text('USE MAX')))
              ],
            ),
            SizedBox(
              height: 36,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
              decoration:
                  InputDecoration(hintText: '0', border: InputBorder.none),
            ),
            SizedBox(
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
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConfirmScreen(
                              currentNetworkController:
                                  currentNetworkController),
                        ));
                      },
                      child: Text('Next')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

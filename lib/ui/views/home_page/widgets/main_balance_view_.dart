import 'package:flutter/material.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';

class MainBalanceView extends StatelessWidget {
  final AccountBalanceController accountBalanceController;
  final CurrentNetworkController currentNetworkController;
  final SettingsController settingsController;
  const MainBalanceView(
      {super.key,
      required this.accountBalanceController,
      required this.settingsController,
      required this.currentNetworkController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListenableBuilder(
            listenable: settingsController,
            builder: (context, child) {
              if (settingsController.settings.hideBalance) {
                return Flexible(
                    child: Text('••••••••',
                        style: Theme.of(context).textTheme.displayMedium));
              }
              return ListenableBuilder(
                  listenable: accountBalanceController,
                  builder: (context, child) {
                    if (accountBalanceController.isLoading) {
                      return Flexible(
                          child: Text('Loading...',
                              style:
                                  Theme.of(context).textTheme.displayMedium));
                    }
                    if (accountBalanceController.failed) {
                      return Flexible(
                          child: Text('Error!',
                              style:
                                  Theme.of(context).textTheme.displayMedium));
                    }
                    return Flexible(
                      child: Text(
                        '${formatEther(accountBalanceController.balance)} ${currentNetworkController.currentConnectedNetwork?.ticker}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  });
            }),
        IconButton(
            onPressed: () async {
              await settingsController
                  .setHideBalance(!settingsController.settings.hideBalance);
            },
            icon: ListenableBuilder(
                listenable: settingsController,
                builder: (context, child) {
                  if (settingsController.settings.hideBalance) {
                    return const Icon(Icons.visibility_off_rounded);
                  }
                  return const Icon(Icons.visibility_rounded);
                }))
      ],
    );
  }
}

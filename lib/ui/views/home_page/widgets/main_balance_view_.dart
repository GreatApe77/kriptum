import 'package:flutter/material.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';

class MainBalanceView extends StatelessWidget {
  final AccountBalanceController accountBalanceController;
  const MainBalanceView({super.key, required this.accountBalanceController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListenableBuilder(
            listenable: accountBalanceController,
            builder: (context, child) {
              return Flexible(
                child: Text(
                  accountBalanceController.isLoading
                      ? 'Loading...'
                      : formatEther(accountBalanceController.balance),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 36),
                ),
              );
            }),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.remove_red_eye_rounded))
      ],
    );
  }
}

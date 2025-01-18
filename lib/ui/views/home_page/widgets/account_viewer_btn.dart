import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';

class AccountViewerBtn extends StatelessWidget {
  final Account account;
  final Function() onPressed;
  const AccountViewerBtn({
    super.key,
    required this.account,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Jazzicon.getIconWidget(
                  Jazzicon.getJazziconData(20, address: account.address),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text(account.alias??'Account ${account.accountIndex + 1}',overflow: TextOverflow.fade,)),
                const Icon(Icons.keyboard_arrow_down)
              ],
            ),
            Text(
              formatAddress(account.address),
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/shared/utils/format_address.dart';

class AccountTileWidget extends StatelessWidget {
  final Function()? onSelected;
  final Function()? onOptionsMenuSelected;
  final bool includeMenu;
  final bool isSelected;
  final Account account;
  final EtherAmount? balance;
  final String ticker;
  const AccountTileWidget(
      {super.key,
      required this.onSelected,
      this.isSelected = false,
      required this.account,
      required this.onOptionsMenuSelected,
      this.includeMenu = false,
      this.balance,
      this.ticker = ''});

  @override
  Widget build(BuildContext context) {
    final title = account.alias ?? 'Account ${account.accountIndex + 1}';
    return ListTile(
      onTap: onSelected,
      selected: isSelected,
      leading: Jazzicon.getIconWidget(
        Jazzicon.getJazziconData(
          40,
          address: account.address,
        ),
      ),
      trailing: includeMenu
          ? IconButton(
              onPressed: onOptionsMenuSelected,
              icon: const Icon(
                Icons.more_vert_rounded,
              ),
            )
          : null,
      title: balance == null
          ? Text(
              title,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), Text('${balance?.toEther(fractionDigitAmount: 5)} $ticker')],
            ),
      subtitle: account.isImported
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatAddress(account.address)),
                Text(
                  'IMPORTED',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                )
              ],
            )
          : Text(
              formatAddress(
                account.address,
              ),
            ),
      //subtitle: Text('${formatAddress(account.address)} ${account.isImported?'SIM':'NAO'}'),
    );
  }
}

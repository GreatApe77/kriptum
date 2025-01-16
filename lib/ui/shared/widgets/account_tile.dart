import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';

class AccountTile extends StatelessWidget {
  final Function()? onSelected;
  final Function()? onOptionsMenuSelected;
  final bool includeMenu;
  final bool isSelected;
  final Account account;
  const AccountTile(
      {super.key,
      required this.onSelected,
      this.isSelected = false,
      required this.account,
      required this.onOptionsMenuSelected,
      this.includeMenu = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      leading: Jazzicon.getIconWidget(
        Jazzicon.getJazziconData(20, address: account.address),
      ),
      trailing: includeMenu?
      IconButton(onPressed: onOptionsMenuSelected, icon: const Icon(Icons.more_vert_rounded))
      :null,
      title: Text(account.alias ?? 'Account ${account.accountIndex + 1}'),
      subtitle: Text(formatAddress(account.address)),
    );
  }
}

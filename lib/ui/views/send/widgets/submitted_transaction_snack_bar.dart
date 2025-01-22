import 'package:flutter/material.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/network.dart';

SnackBar buildSubmittedTransactionSnackBar(
    BuildContext context, final Function(BuildContext context) onTap) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      content: ListTile(
        onTap: () => onTap(context),
        leading: Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.primaryFixed,
        ),
        title: Text(
          'Transaction Confirmed!',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Text(
          'Display transaction information',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ));
}

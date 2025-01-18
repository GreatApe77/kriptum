import 'package:flutter/material.dart';

SnackBar buildWaitngTransactionSnackBar(BuildContext context) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      content: ListTile(
        leading: const CircularProgressIndicator(),
        title: Text(
          'Transaction Submited',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Text(
          'Waiting for confirmation...',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ));
}

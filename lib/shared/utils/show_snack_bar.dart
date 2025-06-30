import 'package:flutter/material.dart';

enum SnackBarType { error, info }

void showSnackBar({
  required String message,
  required BuildContext context,
  SnackBarType snackBarType = SnackBarType.info,
}) {
  dynamic snackBarToChoose;

  switch (snackBarType) {
    case SnackBarType.info:
      snackBarToChoose = SnackBar(
        content: Text(message),
      );
      break;
    case SnackBarType.error:
      snackBarToChoose = SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
      );
      break;
  }
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(snackBarToChoose);
}

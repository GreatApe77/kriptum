import 'package:flutter/material.dart';

SnackBar buildPasswordDontMatchAlert(BuildContext context) {
  return  SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text('Passwords don\'t match'));
}

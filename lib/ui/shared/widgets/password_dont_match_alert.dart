import 'package:flutter/material.dart';

SnackBar buildPasswordDontMatchAlert() {
  return const SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Colors.red,
      content: Text('Passwords don\'t match'));
}

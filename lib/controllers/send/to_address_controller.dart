import 'package:flutter/material.dart';

class ToAddressController extends ChangeNotifier {
  String _toAddress = '';
  String get toAddress => _toAddress;
  void setToAddress(String toAddress) {
    _toAddress = toAddress;
    notifyListeners();
  }

  bool isValid() {
    return _toAddress.length == 42;
  }
}

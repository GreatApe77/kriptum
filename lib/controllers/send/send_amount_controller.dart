import 'package:flutter/material.dart';
import 'package:kriptum/shared/utils/convert_eth_to_wei.dart';

class SendAmountController extends ChangeNotifier {
  BigInt _amount = BigInt.from(0);
  BigInt get amount => _amount;

  //String errorMessage = '';

  void updateAmountValueInEth(String amountValueInEth) {
    _amount = convertEthToWei(amountValueInEth);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:kriptum/shared/utils/convert_eth_to_wei.dart';

class SendAmountController extends ChangeNotifier {
  BigInt amount = BigInt.from(0);
  //String errorMessage = '';

  void updateAmountValueInEth(String amountValueInEth){
    amount = convertEthToWei(amountValueInEth);
    notifyListeners();
  }
}

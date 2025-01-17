import 'package:kriptum/shared/utils/convert_eth_to_wei.dart';

class BalanceValidatorController {
  static bool validateBalance(String amountToSend,BigInt accountBalance){
    BigInt amountToSendInWei = convertEthToWei(amountToSend);
    bool notExceedsBalance = amountToSendInWei<=accountBalance;
    return notExceedsBalance;
  }
}
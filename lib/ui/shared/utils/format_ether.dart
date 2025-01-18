import 'package:web3dart/web3dart.dart';

String formatEther(BigInt amountInWei) {
  return EtherAmount.fromBigInt(EtherUnit.wei, amountInWei)
      .getValueInUnit(EtherUnit.ether)
      .toStringAsFixed(2);
}

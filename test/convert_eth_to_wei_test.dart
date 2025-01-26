import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/shared/utils/convert_eth_to_wei.dart';

void main() {
  test(
    'Should convert a eth value formated in String to wei in BigInt data type',
    () {
      
      String valueInEth = '6.8273';
      BigInt expectedResult = BigInt.parse('6827300000000000000');
  
      final result = convertEthToWei(valueInEth);
      
      expect(result, expectedResult);
      //expect(true, true);
    },
  );
  test(
    'Should convert a eth value formated in String to wei in BigInt data type (large number with ,)',
    () {
      
      String largeEthAmount = '9000000002,7128756404568';
      BigInt expectedResultForLargeAmount = BigInt.parse('9000000002712875640456800000');
      final result = convertEthToWei(largeEthAmount);
      
      expect(result,expectedResultForLargeAmount);
      //expect(true, true);
    },
  );
  test(
    'Should throw when receive a invalid input',
    () {
      
      String invalidInput = 'This is not even a number';
      expect(()=>convertEthToWei(invalidInput),throwsA(isA<Exception>()));
      //expect(true, true);
    },
  );
}
